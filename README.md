## taskモデル（テーブル）

カラム名|データ型
-|-
name|string
content|text
status|text
deadline|date
___
## herokuデプロイ手順  

1.herokuログイン
> $ heroku login

2.Gitコミットする
> $ git add .  
> $ git commit -m "commit message"

3.heroku アプリ作成  
> $ heroku create

4.Heroku buildpackを追加   
> $ heroku buildpacks:set heroku/ruby  
> $ heroku buildpacks:add --index 1 heroku/nodejs

5.デプロイ  
> $ git push heroku master

6.テーブル作成  
> $ heroku run rails db:migrate