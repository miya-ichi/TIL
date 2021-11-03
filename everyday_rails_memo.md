# Everyday Rails - RSpecによるRailsテスト入門
## モデルスペック
モデルはアプリケーションのコアとなる部分であり、モデルのテストを十分に行うことで、土台が堅牢になり、信頼性の高いコードベースを構築できる
### モデルスペックの作成
Railsのジェネレータを使用して生成できる。必ずジェネレータを使用する必要はないが、タイプミスによるエラーを防ぐために、使用する方が良い
- `bin/rails g rspec:model user`

## テスト全般
- 起きて欲しいことと、起きてほしくないことをテストする
- 境界値をテストする
- 可読性を上げる
- テストはアプリケーションの要件とコードを熟考する良い機会
- テストはDRYよりも読みやすいことの方が重要
### マッチャ
- be_valid
  - バリデーションを通るか
- eq
  - 後に続く条件と同じ結果か
- include
  - 後に続く要素を含むか
- be_empty
  - 要素が空かどうか
### describeとcontextの使い分け
describeとcontextはエイリアスでありどちらを用いても動作は変わらないが、スペックの可読性を考慮し使い分ける
- describeはクラスやシステムの機能に関するアウトラインを記述
- contextは特定の状態に関するアウトラインを記述
### bofore
- before(:each)
  - 各テストの前に実行
- before(:all)
  - 全テストの前に1回だけ実行
- before(:suite)
  - テスト全体（全ファイル）の前に1回だけ実行

## Factory Bot
PORO(plain old Ruby objects)ごく普通のRubyオブジェクト
ジェネレータを使用したファクトリファイルの作成
- `bin/rails g factory_bot:model user`

- FactoryBot.build モデルのインスタンスのみ作成（DBに保存しない）
- FactoryBot.create データベースに保存までする

### シーケンス
ファクトリを記述する際に、ユニークにすべき属性に対して設定する。  
ファクトリから新しいオブジェクトを作成する際に、設定した属性にはカウンタを１ずつ増やしながらユニークな値を登録していく  
`sequence(:email) { |n| "tester#{n}@example.com" }`
- Rubyのコードのようにブロックを使い、式展開で変数の値を増加しながら設定してく感じか

### ファクトリの関連
複数のモデルが関連を持っている場合に、データをそれぞれに作成するのは手間になるが、  
ファクトリ内で関連する他のファクトリを`association :project`のような形で指定すると、  
一つのテストデータの作成時に関連するデータも作成してくれる

### ファクトリの継承
内容の一部が異なるファクトリを複数定義する際に重複なく定義するための方法
継承元のファクトリ内に継承するファクトリの、変更する部分のみを入れ子の形で定義する
```ruby
# 例
factory :project do
  name "test"
  due_on 1.week.from_now

  factory :project_due_yesterday do
    due_on 1.day.ago
  end
end
```

### トレイト(trait 特性)
ファクトリの継承と同じく、重複をなくすための方法  
また、複数のトレイトを組み合わせて複雑なオブジェクトを構築するために使うことができる
```ruby
# 例
factory :project do
  name "test"
  due_on 1.week.from_now

  trait :due_yesterday do
    due_on 1.day.ago
  end
end
```
トレイトを使う場合は、スペックの書き方が少し変わる
```ruby
project = FactoryBot.create(:project, :due_yesterday)
                                      ^^^^^^^^^^^^^^
```

## コントローラスペック
コントローラスペックは現在推奨されていない(モデルスペックかシステムスペック等への置き換えを推奨)
> コントローラのテストは対象となる機能の単体テストとして最も有効活用できるときだけ使うのが良い

## フィーチャスペック
統合テストとも呼ばれる。モデル・コントローラを含めたアプリケーション全体のテスト  
最新のRSpecでは同じ全体のテストとして、フィーチャースペックとともに、システムスペックがサポートされている。  
Railsの開発からは、システムスペックの使用が推奨されている(参考：現場本)

featureとscenarioで構造を作る

## リクエストスペック
APIをテストするために使用できる
`bin/rails g rspec:request projects_api`
コントローラスペックはリクエストスペックに置き換えることが可能(リクエストスペックの使用を推奨)

## DRYなスペック
テストコードの重複をなくし、共通化する方法がいくつかある。
### サポートモジュールを使用した共通化
- `spec/support`内に`login_support.rb`のような形でファイルを用意する

```ruby
module LoginSupport
  def メソッド名
    共通化する処理
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
```
上記のようにファイル内にRSpecで読み込む設定を書く方法と、使用するスペックでincludeする方法もある
- フィーチャスペックでよく使う
- モジュール内のメソッド名は目的がすぐにわかるものにする(いちいち定義しているファイルを見なくてもいいように)

### letによる遅延読み込み
beforeブロックによるインスタンス変数の初期化のデメリット
- 各テストの前に毎回実行されるため、テストが遅くなる要因となる
- 初期化する要件が多くなると、可読性が悪くなる
letを使用すると、定義した部分ではデータの登録は行われず、実際に呼び出された時に登録される。
let!を使用すると、定義した部分でデータの登録が行われる

### shared_context
複数のテストファイルで必要な処理を共通化することができる
`spec/support/contexts/`内に`project_setup.rb`のような形でファイルを作成

```ruby
RSpec.shared_context "project setup" do
  共通化する処理
end
```
呼び出す際は`include_context "project setup"`と記述する
