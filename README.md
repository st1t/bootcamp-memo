![Ruby](https://github.com/st1t/bootcamp-memo/workflows/Ruby/badge.svg)

# memo_sinatra

Sinatraでmemoアプリを作るフィヨルドブートキャンプ課題用リポジトリ。  
dbディレクトリ配下にメモの内容をjsonファイルとして保存する。

# 起動方法

```
$ docker-compose up -d
$ bundle install
$ bundle exec ruby app.rb
```

# DB削除方法

```
$ docker-compose rm -f
$ docker volume rm memosinatra_postgres_data_volume
```
