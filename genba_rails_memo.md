# 現場で使えるRuby on Rails 5速習実践ガイド
## Chapter2 Railsアプリケーションを覗いてみよう
### Railsでアプリケーションを動かす
`rails nes アプリ名`で作業ディレクトリ下にアプリケーションの雛形となるフォルダとファイルが自動生成される
- 上記コマンドだとDBにSQLite3が使用される。`-d DBソフト名`で特定のDBを使用する設定ができる

`bin/rails db:create`でデータベースを作成
- bin/railsコマンドはGemfile通りのGemを使用する環境上でrailsを実行できる

`bin/rails s`でサーバーを起動。http://localhost:3000/ にアクセスするとRailsのページが表示される
- HTTPサーバーは標準ではPumaが使われている。
### ユーザー管理機能の雛形をつくる
```
bin/rails generate scaffold user name:string address:string age:integer
bin/rails db:migrate
bin/rails s
```
上記コマンドにてユーザー管理機能の雛形を簡単に作成できる  
この雛形は作成(Create),読み出し(Read),更新(Update),削除(Delete)の機能を持っている。
- 上記4機能はまとまって扱う場合が多い。頭文字を取って*CRUD*と呼ぶ

### MVC
RailsアプリケーションはM(モデル),V(ビュー),C(コントローラ)という考え方で構成されている  
### コントローラ
クライアントからのリクエストを受け、適切なレスポンスを返すための制御を行う  
まずリクエストが来たら、routes.rbに定義されたルーティング情報から、リクエストを担当する箇所を特定する(どのコントローラのどのアクションが実行するかを決める)  
### モデル
データとデータに関連する処理を行う  
コントローラのアクションから必要に応じて呼び出される
### ビュー
ブラウザに表示される画面を出力するコード  
ERBを使って記述する  
HTMLの中にRubyのコードを埋め込むことができる
ヘルパーメソッドというビューの中で使用できる機能がある(自分で定義することもできる)  
<html>タグなどの共通のパーツはレイアウトファイルにまとめてあり、  
個別の部分のみ各アクションごとに分けられたhtml.erbファイルに記述する  

## Chapter3 タスク管理アプリケーションを作ろう
### テンプレートエンジン
HTMLを出力する際に使用する。動的な処理を記述する際に内容が直感的でわかりやすいような書き方ができる
- ERB
- Haml
- Slim
### モデルの構成要素
- モデルに対応するRubyのクラス
- モデルに対応するデータベースのテーブル
### 命名規則
データベースのテーブル名:モデルのクラス名を複数形にする  
モデルのクラス名はキャメルケース、テーブル名はスネークケース
### コントローラの作成
ジェネレータで作成できる。アクションもセットで作成すると効率が良い  
CRUD機能のアクションはパターン化されている
### RESTful
設計思想。後述  
### Strong Parameters
受け取ったデータが不正なデータではないか確認した上で、必要なデータを取得する仕組み
### Flashメッセージ
リダイレクトするときに次のリクエストに対してデータを伝える仕組み
### パーシャル
viewの一部を共通化
## Chapter4
### マイグレーション
データベースのテーブルの追加・削除などの操作をRailsを介して行うことができる機能  
Rubyのコードで書かれたマイグレーションファイルに操作を記述する  
マイグレーションファイルはデータベースに対する操作を行うたび作成するため、  
それがデータベースの変更履歴となり、チーム開発の場合メンバーが確認しやすくなる  
マイグレーションの適用＝データベースのバージョンが1つ上がる
- db:migrate : 最新までマイグレーションを適用する
- db:migrate VERSION=○◯ : 特定のバージョンまでマイグレーションが適用された状態にする
- db:rollback : バージョンを1つ戻す
- db:rollback STEP=◯ : バージョンを指定した数戻す
- db:migrate:redo : バージョンを1つ戻してから1つ上げる

マイグレーションの適用中に、コードの不備などでエラーとなり途中で終了した場合は、  
エラーの出たマイグレーションの前までが適用された状態となり、その後の分は適用されない  
### 検証(バリデーション)
データベースに不正な値が記録されないように、ユーザーから入力された値が正しいものかを確かめること。  
モデルでチェックを行うのが一般的。Railsではその仕組みが用意されている  
自分で検証用のコードを書くこともできるし、既存の検証用のヘルパーを使用することもできる。
### コールバック
### トランザクション
### フィルタ

## Chapter5 テストをはじめよう
### テストを自動化するメリット
- アプリケーションをリリースした後で機能の追加等を行う際に、新機能以外に既存機能が想定通りに動くかを確認する必要があるが、毎回各機能を手動でテストするのは、アプリケーションの規模が大きくなるほどコストも増大していく。自動化することでそのコストを削減することができる
- 上記のように機能追加等の際のテストのコストが下がることで、早いスピードで機能追加・変更を行うことができるようになる

### テストに利用するライブラリ
- RSpec
  - RubyにおけるBDDのためのテスティングフレームワーク
  - 動く仕様書(Spec)として自動テストを書くという発想で作られている
  - 要求仕様をドキュメントに記述するような感覚でテストケースを記述できる
- Capybara
  - WebアプリケーションのE2Eテスト用フレームワーク
  - RSpecと組み合わせて使う
  - Webアプリケーションのブラウザ操作をシミュレーションできる
- FactoryBot
  - テスト用のデータ作成をサポートするライブラリ

### テストの種類
- システムテスト(System Spec)
- 結合テスト(Request Spec)
- 機能テスト(Controller Spec)
- 個々の部品のテスト
  - モデル・ビュー・ルーティング・ヘルパー・メーラー・ジョブ

### RSpecによるSpecの書き方
難しいので別で勉強します。。。

## Chapter6 Railsの全体像を理解する
### ルーティング
どのようなURLへどのようなHTTPメソッドでアクセスされたら、どのコントローラのどのアクションを呼び出したいかをconfig/routes.rbに定義する。このように、アクセスを受けて適切なアクションへと案内する仕組みをルーティングと呼ぶ

### RESTfulについて
REST(REpresentational State Transfer)という設計原則し従うシステムのことを指す。  
1. HTTPリクエストはそのリクエストで必要な情報を全て持ち、前のリクエストからの状態が保存されている必要がない(ステートレス)
2. 個々の情報(リソース)への「操作」の表現がHTTPメソッドとして統一されている
3. 個々の情報(リソース)がそれぞれ一意なURIで表されている
4. ある情報(リソース)から別の情報を参照したい時は、リンクを利用する

RESTfulなシステムを開発するためのRailsの特徴
- URLが表す情報のことをリソースと呼ぶ
- 一般的なブラウザのサポートするGET/POST以外にPATCH/PUT/DELETEなどのHTTPメソッドをサポートする
- 操作はHTTPメソッドで行うものとし、URLで表現しないようにする。そのためURLは名詞にする

### Strong Parameters
ユーザーからのリクエストに含まれるパラメータがアプリ側で想定した値になっているかをチェックする機能  
悪意のあるユーザーから不正なパラメータを送られても、受け付けないようにする。  
上段にも同じようなことメモってた。

### アセットパイプライン
JavaScript,CSS,画像などのアセットを効率的に読み込めるように、コンパイル・連結・圧縮などする機能。  
sprockets-railsというGemがやっている
https://railsguides.jp/asset_pipeline.html

どうでもいいけどここのChapter眠たかった・・・

## Chapter7 機能を追加してみよう