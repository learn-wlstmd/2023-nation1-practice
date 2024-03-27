## 파일 옮기기
```
scp -i /path/to/mykey.pem -r Downloads/Zip/ ec2-user@서버주소:/
```

## MySQL install in Amazon Linux 2023
```
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum update

sudo dnf install mysql-community-server

sudo systemctl start mysqld
sudo systemctl status mysqld

# sudo yum install openssl-libs
# sudo yum update
```

## MySQL Connect Command
```
mysql -h <RDS_endpoint> -P 3306 -u <master_username> -p
```

## In MySQL Command
```
USE dev;

CREATE TABLE product (
    id VARCHAR(255),
    name VARCHAR(255)
);

SOURCE ./insert.sql;
SELECT * FROM product LIMIT 3;
```

## Secret Manager Command
```
aws secretsmanager create-secret --name dbsecret \
    --description "Database connection info" \
    --secret-string '{
        "username": "root",
        "password": "비밀번호",
        "engine": "mysql",
        "host": "RDS엔드포인트",
        "port": "3306",
        "dbname": "dev"
    }' \
    --region ap-northeast-2
```

## Go
```
go mod init <모듈 이름>
go mod tidy
```

## Docker ecr Login Solution
```
sudo usermod -aG docker $USER

sudo systemctl start docker

sudo aws ecr get-login-password --region ap-northeast-2 | sudo docker login --username AWS --password-stdin 362708816803.dkr.ecr.ap-northeast-2.amazonaws.com
```