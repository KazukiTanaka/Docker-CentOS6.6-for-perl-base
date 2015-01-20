# Docker-CentOS6.6-for-perl-base
## これはなに？
centOSにPerl開発環境を入れたdocker imageの作成とS3によるリポジトリ管理を行うサンプル
OSやミドルウェアを共通image化してdocker buildを早くする

## 環境構築
1 . S3にバケット作る

2 . S3にアクセス可能なIAM作る(Key と SECRETメモ)

3 . 以下のパラメータを設定

```
# aws s3コマンドで使う  
aws config
# docker run stackbrew/registry で使う
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export DOCKER_REPOSITORY_BUCKET=
```

4 . S3をファイルサーバにしたDockerリポジトリ起動(stackbrew/registry)
```
sh run_s3_repository.sh
```

5 . Dockerfileを書く（既に書いてある）

```
vim dockerfiles/centos_perl/Dockerfile 
```

6 . 作成したDcokerfileからimageを生成し、S3にpush

```
sh script/build_image_and_push_to_s3.sh
```

7 . pushしたimageをbaseにDockerfileを作成(サンプル)

```
FROM 127.0.0.1:49000/centos6.5perl5.18.2

RUN yum update -y
RUN yum install -y openssl-devel

# mkdir app dir
ENV APPROOT /src/app
RUN mkdir -p $APPROOT
WORKDIR $APPROOT

# copy & carton install
ENV SAMPLE_APP_ROOT ./sample_app
COPY $SAMPLE_APP_ROOT/cpanfile $APPROOT/cpanfile
RUN plenv exec carton install
COPY $SAMPLE_APP_ROOT $APPROOT

# run app
EXPOSE 5000
CMD ["script/app.sh"]
```

# Elastic Beanstalk でstackbrew/registryを使う場合
* 以下のコマンドを実行。S3にIMAGE実体がファイルとしておかれるので、EBから立ち上げるのが早くなる

```
sh script/build_registry_image_and_put_to_s3.sh 
```