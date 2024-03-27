package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	_ "github.com/go-sql-driver/mysql"
)

type DBInfo struct {
    Username string `json:"username"`
    Password string `json:"password"`
    Engine   string `json:"engine"`
    Host     string `json:"host"`
    Port     string `json:"port"`
    DBName   string `json:"dbname"`
}

func getDBSecret(secretName string) (*DBInfo, error) {
    cfg, err := config.LoadDefaultConfig(context.TODO(),
        config.WithRegion("ap-northeast-2"),
    )
    if err != nil {
        return nil, err
    }

    svc := secretsmanager.NewFromConfig(cfg)
    input := &secretsmanager.GetSecretValueInput{
        SecretId: &secretName,
    }
    result, err := svc.GetSecretValue(context.TODO(), input)
    if err != nil {
        return nil, err
    }

    var dbInfo DBInfo
    if err := json.Unmarshal([]byte(*result.SecretString), &dbInfo); err != nil {
        return nil, err
    }

    return &dbInfo, nil
}

func productHandler(db *sql.DB) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {
        if r.Method != http.MethodGet {
            http.Error(w, "Unsupported method", http.StatusMethodNotAllowed)
            return
        }

        productName := r.URL.Query().Get("name")
        if productName == "" {
            http.Error(w, "Product name is required", http.StatusBadRequest)
            return
        }

        query := "SELECT COUNT(*) FROM dev.product WHERE name = ?"
        var count int
        err := db.QueryRow(query, productName).Scan(&count)
        if err != nil {
            if err == sql.ErrNoRows {
                http.Error(w, "Product not found", http.StatusNotFound)
                return
            }
            log.Println("Database query error:", err)
            http.Error(w, "Internal server error", http.StatusInternalServerError)
            return
        }

        var response map[string]string
        if count > 0 {
            response = map[string]string{"message": "The product is well in database"}
        } else {
            response = map[string]string{"message": "Product not found"}
        }

        responseJSON, err := json.Marshal(response)
        if err != nil {
            log.Println("Error marshalling response:", err)
            http.Error(w, "Internal server error", http.StatusInternalServerError)
            return
        }

        w.Header().Set("Content-Type", "application/json")
        w.Write(responseJSON)
    }
}

func healthcheckHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    resp := map[string]string{"status": "ok"}
    json.NewEncoder(w).Encode(resp)
}

func main() {
    dbInfo, err := getDBSecret("dbsecret")
    if err != nil {
        log.Fatalf("Failed to get DB secret: %v", err)
    }

    dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true", dbInfo.Username, dbInfo.Password, dbInfo.Host, dbInfo.Port, dbInfo.DBName)

    db, err := sql.Open("mysql", dsn)
    if err != nil {
        log.Fatal("Failed to connect to database:", err)
    }
    defer db.Close()

    http.HandleFunc("/v1/product", productHandler(db))
    http.HandleFunc("/healthcheck", healthcheckHandler)

    fmt.Println("Server is running on :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
