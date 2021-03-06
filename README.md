# mini command palette hidemaru

簡易コマンドパレットです。（実験段階です）

# Features
- マクロファイルの一覧
  - マクロファイルの一覧を自動生成し、好きなものを選んで実行できます。マクロファイルをキー割り当てする必要はありません。
- コマンドパレット
  - VSCodeのコマンドパレット（あるいはブラウザのアドレスバー）などのように、文字を少し入力するだけで目的のマクロファイルを絞り込んで表示し、カーソル上下で選んでENTERで決定できます。
- インクリメンタルサーチと絞り込み
  - タイプするごとに目的の行を絞り込んで表示できます。
- AND検索
  - スペースで区切ることで、AND検索で絞り込みできます。
- migemo
  - 例えば `siyou` とタイプすれば「使用」や「仕様」などを絞り込みできます。
- カスタマイズ
  - 行を自由に追加できます。
  - 別名
    - 例えば、マクロに好きな別名（alias）をつけて使えます。
    - migemoを利用して、日本語の別名をマクロにつけて使えます。
  - 生成
    - マクロの一覧のように、リストを生成して追加できます。
- 編集中ファイルの絞り込みとジャンプ
  - 編集中ファイルをmigemoやAND検索で絞り込み、選んだ行にジャンプできます。

# 何が楽になるの？
- タイプするだけでよい
  - マクロファイルを配置して、コマンドパレットから絞り込みするだけで使えます。
  - マクロごとの割り当てキーを覚える必要がなく、楽です。
- 自分が思い出しやすい単語を別名登録するだけでよい
  - 例えば今日の天気を挿入するマクロと、今日のニュースを挿入するマクロがあり、別名を「今日の天気」「今日のニュース」としてカスタマイズファイルに登録したとします。
    - 「tenki」「news」「nyu-su」などタイプするだけで直感的に使えます。
  - 「どのキーやメニューにマクロを割り当てたのか、忘れてしまいそう」というときに威力を発揮します。
  - 「自分のつけた別名で、すぐ思い出して使えるようにしたい」「頻繁に使うマクロだけど、絞り込みが手間なので、絞り込みやすい別名にしたい」などの場合に便利かもしれません。
  - この別名の使い方は、実験段階ととらえています。
    - 例えばVSCodeでこのようにaliasとして使う事例があるかは、不勉強ゆえ把握していません。
    - 類似の事例として、これを作るきっかけになった [afxfazzy](https://github.com/yuratomo/afxtools) を手元で運用している範囲では大きな成果をあげています。
      - テキストエディタにおいてもこのような使い方はアリかもしれないと考える次第です。
- 編集中ファイルの絞り込みを多段階で行える
  - grepのように複数の検索結果が一覧でき、しかもインクリメンタルサーチのように動的に検索条件を変更でき、しかもmigemoやAND検索ができます。
  - 例えば、ログファイルからエラー行を絞り込み、さらにAND検索で絞り込む、といったことが楽にできます。

# 機能の補足説明
- マクロファイルのリストアップ
  - 初回起動時にコマンドパレット用リストに登録します。
  - 以降はコマンドパレットから「リロード」を選べば更新できます。
  - リストはコマンドパレット側で独立して持っています。秀丸の設定には影響しないのでご安心ください。
- カスタマイズリストとマクロファイルリストの連結
  - リロード時に連結します。
  - カスタマイズリストは、存在しない場合にcustom_sample.macからコピーされます。

# Requirement
- Windows 64bit
- 実行からウィンドウ表示まで待つこと（ウィンドウが出る前にタイプするとウィンドウがアクティブ化しません）
- 遊び心
  - まだ実験的段階のため、課題(後述)があります。使うには遊び心が必要です。

# Install
- ダウンロード
  - 秀丸マクロのディレクトリにて、以下をコマンドプロンプトに貼り付け、ENTERキーを押してください。
  ```
  curl.exe -L https://raw.githubusercontent.com/cat2151/mini-command-palette-hidemaru/main/install/installMiniCommandPalette.bat --output installMiniCommandPalette.bat && installMiniCommandPalette.bat
  ```
- マクロ登録
  - 秀丸を開き、`メニュー/マクロ/マクロ登録` 画面を開いてください。
  - マクロ1～マクロ80のうち、空いている場所に、以下のマクロを登録してください :
    - タイトル :
      - `コマンドパレット`
    - ファイル名 :
      - `miniCommandPalette\miniCommandPalette.mac`
- キー割り当て
  - 秀丸の `メニュー/その他/キー割り当て` 画面を開いてください。
  - `キーに対するコマンド` タブにて、左下の`Shift`と`Ctrl`のチェックを入れてください。
  - `Shift + Ctrl + P` に、「マクロxx : コマンドパレット」を割り当ててください。（xxは1～80の数字）
- テスト
  - `Shift + Ctrl + P` を押し、コマンドパレット画面が開くことを確認してください。
  - `コマンドパレットをカスタマイズ` を選んでENTERを押し、custom.macが開くことを確認してください。
- もしアップデートするときは
  - `ダウンロード`を再度実施するだけでOKです。（設定ファイル上書きはしないのでご安心ください）

# Tutorial
- カスタマイズ
  - 秀丸を開きます。
  - `CTRL + SHIFT + P` を押します。
  - `コマンドパレットをカスタマイズ` を選びます。
  - `custom.mac` が開かれることを確認します。
  - 以下の行を追加します :
    ```
    /* こんにちは */ message "hello, world";
    ```
  - `CTRL + SHIFT + P` を押します。
  - `コマンドパレットをリロード` を選びます。
  - `/* こんにちは */ message "hello, world";`が追加されたことを確認します。
  - `/* こんにちは */ message "hello, world";`を選びます。
    - `kon` や `hel` をタイプして、日本語でも英語でも選べることを確認します。
  - ダイアログ `hello, world` が表示されたことを確認します。
- 編集中ファイルの絞り込み
  - 秀丸で、例えばエラーのあるログファイルを開きます。
  - `CTRL + SHIFT + P` を押します。
  - `編集中ファイルを絞り込み` を選びます。
    - `he` や `fa` や `si` で選ぶと楽です。（それぞれ「編集中」「ファイル」「絞り込み」をmigemo）
  - `error` をタイプします。
  - `ERROR` `error` `エラー` などが絞り込みされたことを確認します。（migemoなので `エラー` もmatchします）
  - 行を選んで `ENTER` を押します。
  - その行にジャンプしたことを確認します。

# 今後
- 以下のような機能があると便利かもしれません。作るかもしれません。作らないかもしれません。
  - 「秀丸が持っている機能」のリスト
  - 「最近編集したファイル」のリスト
  - ブックマークのリスト

# 課題

## VSCodeのコマンドパレットほど多機能ではない
- historyはなく、単語の先頭文字や単語の一部をスペース区切りせず連続入力するだけでマッチさせる機能もなく、接頭辞 `>` や `@` 等による動作切り替えもなし。VSCodeのコマンドパレットのような多機能さはありません。
- 実験段階であるためです。
- 今後機能が増えるかは未定です。増えないかもしれません。

## マクロファイルのリストがフルパスなので選びづらい
- 対策を検討中です。
  - 対策案の候補 :
    - リスト化の際に、scriptにて、先頭に/* foo.mac */のようにマクロファイル名を挿入します。

## 起動を速くするには
- tkinterの最小化関連機能、秀丸のマクロのWindows関連機能、を使って、常駐型にできれば高速そうです。（できるかは不明です）
- VC++で作れば高速そうです。参考は [afxfazzy](https://github.com/yuratomo/afxtools)
- テキストエディタのプラグインとしてDLLで作れば高速そうです。
- いつ作るかは未定です。作れないかもしれません。

## 名前が長すぎて扱いづらい
- もしVC++版やテキストエディタのプラグイン版を作れたらそのときはより短い名称を考えるかもしれません。
