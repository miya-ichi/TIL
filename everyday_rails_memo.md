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
