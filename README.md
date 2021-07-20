# Sample Concurrency

async/awaitを利用した並行処理のサンプルコード。

## Single: APIを1つコール

以下のAPIをそれぞれ取得。

- GithubのRepository取得
- QiitaのItem取得

## Serial: 直列で2つのAPIをコール

- まず、QiitaのTag取得を取得  
https://qiita.com/api/v2/tags?page=1&per_page=10&sort=count
- 次に、取得した最初のQiitaTagのItemを取得  
https://qiita.com/api/v2/docs#get-apiv2tagstag_iditems

## Parallel: 並列で2つのAPIをコール

2つのAPIを同時にコールして、同時に表示

- https://api.github.com/search/repositories?q=swift
- https://api.github.com/search/repositories?q=kotlin