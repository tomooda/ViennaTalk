# Lively Walk-Through チュートリアル: Tic-Tac-Toe

## 目次

* [概要](#abstract)
* [準備](#preparation)
* [Lively Walk-Through を起動する](#launch-LivelyWalkThrough)
* [VDM-SL仕様を読み込む](#read-spec)
* [Tic Tac Toe ゲームの盤面を配置する](#board)
* [升目を表示するウィジェットを1つ配置する](#C11)
* [LiveTalk スクリプトで石の表示を切り替える仕組みを作る](#script)
* [C11を複製して3x3の升目を作る](#3x3)
* [ゲーム開始ボタンを作る](#start)
* [UIの配置を固定する](#fix-position)
* [Tic Tac Toe をプレイしてみる](#play)
* [UIプロトタイプをファイルに保存する](#save)
* [まとめ](#summary)

  
<a name="abstract"></a>
## 概要

Tic Tac Toe は2人で遊ぶゲームで、3x3の格子状の升目に2人のプレーヤーが交互に石を置き、自分の石が縦、横、または斜めに3つ並んだら勝ち、3つ並ばずに全ての升目が埋まったら引き分けとなるゲームです。

このチュートリアルでは、コンピュータを相手に遊ぶ Tic Tac Toe ゲームの仕様を使ってゲームの UI プロトタイプを Lively Walk-Through 上に作成することを通して、Lively Walk-through の使い方を学びます。

<a name="preparation"></a>
## 準備
### ViennaTalk
ViennaTalkを [ViennaTalk リリースページ](https://github.com/tomooda/ViennaTalk-doc/releases)から入手してください。

### チュートリアル用リソース
このチュートリアルには以下のファイルが必要です。
このチュートリアルのResourcesディレクトリから入手してください。

* TicTacToe.vdmsl (Tic Tac Toe ゲームの VDM-SL仕様)
* board.png (盤面の画像、紙の上に「＃」が描かれています)
* O.png (プレーヤーの石の画像、透明な背景に「○」が描かれています)
* X.png (コンピュータの石の画像、透明な背景に「×」が描かれています)
* empty.png (空升の画像、透明な画像です)

<a name="launch-LivelyWalkThrough"></a>
## Lively Walk-Through を起動する
まず、ViennaTalkを起動してください。

MacならばViennaTalkアイコンをダブルクリック、Windowsならば ViennaTalk\pharo.exe、Linuxならば ViennaTalk/pharo を実行してください。

![ViennaTalk](images/001-open-ViennaTalk.png =400x)

続いて、ViennaTalk Launcher の Toolsメニューから、「Lively Walk-Through」を開きます。

![Lively Walk-Through menu](images/002-open-LivelyWalkThrough.png =400x)

![Lively Walk-Through window](images/003-LivelyWalkThrough.png =400x)

これで Lively Walk-Through が起動しました。
これから Lively Walk-Through 上に Tic-Tac-Toe ゲームのUI プロトタイプを作成します。

<a name="read-spec"></a>
## VDM-SL仕様を読み込む
Tic Tac ToeゲームのVDM-SL仕様を Lively Walk-Through に読み込みます。

Lively Walk-Throughの上部右側のタブから「VDM Browser」を選択してください。

![VDMBrowser](images/004-open-VDMBrowser.png =400x)

上段左側の「DEFAULT」と書いてあるリスト上で右クリックして、「New and load...」を選んでください。

![new and load](images/005-newAndLoad.png =400x)

ファイルを選択するダイアログが開くので、TicTacToe.vdmsl を選んでください。

![Tic Tac Toe](images/006-TicTacToe.vdmsl.png =400x)

Tic Tac Toe ゲームの VDM-SL 仕様が読み込まれました。

この仕様が定義しているAPIのうち、このUIプロトタイプでは

* get : nat * nat ==> [&lt;O&gt; | &lt;X&gt;]
* play : nat * nat ==> Status

の2つの操作を使います。

get操作は引数で指定された升目の石を返します。ユーザが置いた石があれば&lt;O&gt;、コンピュータが置いた石があrば&lt;X&gt;、石がなければnilを返します。

play操作は引数で指定された升目にユーザの石を置きます。返り値はゲームの状態を表しますが、このUIプロトタイプではその内容にあまり意味はありません。

<a name="board"></a>
## Tic Tac Toe ゲームの盤面を配置する
Tic Tac Toeで遊ぶためのUIプロトタイプを作成します。

まずは盤面の画像を配置します。
Lively Walk-Throughの上部右側のタブからWidgetsを選択してウィジェットパレットからImageウィジェットをドラッグして左側のプロトタイプスペースに置いてください。

![Widgets pallette](images/007-ImageWidget.png =400x)

![Image widget](images/008-placed-ImageWidget.png =400x)

Imageウィジェットに盤面の画像ファイル(board.png =400x)を表示するよう設定します。
プロトタイプスペースのImageウィジェット上で右クリックでメニューを出し、「change image...」を選択してください。

![chagne image](images/009-ChangeImage.png =400x)

ファイルダイアログが開きます。 board.png を選択してください。

![choose image](images/010-choose-ImageFile.png =400x)

するとImageウィジェットに盤面画像が表示されます。

![image widget](images/011-ImageWidget.png =400x)

十分に大きなサイズになるよう、画像の右下をドラッグして調整してください。

![resize widget](images/012-resize-ImageWidget.png =400x)

これで Tic Tac Toeを遊ぶための盤面の画像を配置できました。

<a name="C11"></a>
## 升目を表示するウィジェットを1つ配置する

ゲーム画面として、石を表示するための仕組みを作ります。

Lively Walk-ThroughにはVariableImageウィジェットがあります。
VariableImageウィジェットは、保持する値に応じて表示する画像をあらかじめ定義することで、保持する値をグラフィカルに表現するためのウィジェットです。
Tic Tac Toe の仕様では、get操作を呼び出すと、引数で指定された位置の升目の値として「○」が置かれていたら &lt;O&gt;、「×」が置かれていたら &lt;X&gt;、何も置かれていなければ nil が得られます。
VariableImageウィジェットにそれら3つの値に対応する画像を指定しておいて、get操作の結果をVariableImageウィジェットに渡すことで、Tic Tac Toe の盤面を更新することができます。

まずは 3x3 の升目のうち左上の升目を作ります。

Lively Walk-Through の右側のウィジェットパレットからVariableImageウィジェットを盤面の左上に配置します。

![VariableImage widget](images/013-VariableImageWidget.png =400x)

![VariableImage widget placed](images/014-placed-VariableImageWidget.png =400x)

置いたVariableImageウィジェットは左上の升目を表します。
名前を C11 に変更します。
置いたVariableImageウィジェット上で右クリックメニューから change nameを選択してください。

![change name](images/015-ChangeName.png =400x)

そして、ウィジェット名として「C11」と入力してください。

![enter C11](images/016-ChangeName-C11.png =400x)

次に、升目の状態ごとに表示する画像を設定します。
まずは、「&lt;O&gt;」に対応する画像として、images/O.pngを指定します。
右クリックメニューで、「add mapping」を選択してください。

![add mapping](images/017-AddMapping.png =400x)

対応させる値を指定します。「&lt;O&gt;」と入力してください。

![add mapping key O](images/018-AddMapping-O.png =400x)

次に、「&lt;O&gt;」に対応させる画像を指定します。ファイルダイアログが開くので、このチュートリアルに同梱されている images/O.png を指定してください。

![assign image to O](images/019-AddMapping-image.png =400x)

同様にして、「&lt;X&gt;」に images/X.png を対応させてください。

![assign image to X](images/022-AddMapping-image.png =400x)

最後に、デフォルトの画像として、 images/empty.png を指定してください。

![change default image](images/023-ChangeDefaultImage.png =400x)

升目を表すウィジェットの大きさを盤面の画像での升目にあうように大きさや位置を調整してください。
これで左上の升目を表すウィジェットの設定ができました。

<a name="script"></a>
## LiveTalk スクリプトで石の表示を切り替える仕組みを作る
画面を更新する仕組みを作ります。

Lively Walk-Throughでは、VDM-SL仕様と画面を連動させる仕組みとして、LiveTalkというミニ言語を使います。
LiveTalkでは、ウィジェットに発生したイベントに対するアクションを定義します。
イベントには、「clicked」のように直接ユーザの操作によって発生するイベントと、
「assigned」のようにウィジェットに対する操作によっても発生するイベントがあります。
今回は升目を表すウィジェットの「clicked」イベントを使ってプレーヤーが入力した「手」をVDM-SL仕様に伝え、
入力フィールドウィジェットの「assigned」イベントを使って画面を更新する仕組みをLiveTalkを使って記述します。

まずは、「assigned」イベントを使って画面を更新する仕組みを記述します。
ウィジェットパレットからFieldウィジェットをドラッグして、左側の盤面外のどこかに配置してください。

![field widget](images/024-Field.png =400x)

![placed field widget](images/025-placed-Field.png =400x)

Fieldウィジェットのウィジェット名を「Status」に設定します。
配置したFieldウィジェットの右クリックメニューで「change name」を選んでください。

![change name](images/026-ChangeName-Field.png =400x)

ウィジェット名として「Status」と入力してください。

![change name to Status](images/027-ChangeName-Status.png =400x)

この「Status」ウィジェットの「assigned」イベントに対するアクションを定義します。
画面上端右のタブから「LiveTalk」をクリックしてください。
すると、ウィンドウの右半分がウィジェットパレットからLiveTalkブラウザに切り替わります。

![LiveTalk tab](images/028-open-LiveTalkBrowser.png =400x)

「Status」ウィジェットのassignedイベントに対するアクションとして、VDM-SL仕様の`get(1,1)`を呼び出して、結果を「C11」ウィジェットに渡しなさい、という動作を定義します。

以下の内容をLiveTalkブラウザの下半分に入力して、右クリックメニューから「Accept」を選択してください。

```
Status`assigned
    get(1,1) -> [C11]
```

![Status script](images/029-StatusScript.png =400x)

文法に誤りがなければ、LiveTalkブラウザの上側のリストにさきほど定義したスクリプトが「Status`assigned」として追加されます。

![script added](images/030-added-StatusScript.png =400x)

次に、プレーヤーの手をVDM-SLに伝えるスクリプトを作成します。
C11が押されたら左上の升目に石を置くように、以下の内容をLiveTalkブラウザの下半分に入力し、右クリックメニューから「Accept」を選択してください。

```
C11`clicked
    play(1,1) -> [Status]
```

![C11 script](images/031-added-C11Script.png =400x)

これで、

1. ユーザが「C11」ウィジェット上でクリックすると、VDM-SL仕様で`play(1,1)`を実行し、その結果を「Status」ウィジェットに渡す。
2. 「Status」ウィジェットが値を渡されたら、VDM-SL仕様で`get(1,1)`を実行し、その結果を「C11」ウィジェットに渡す。
3. 「C11」ウィジェットは渡された値に応じて表示する画像を切り替える。「&lt;O&gt;」ならば○、「&lt;X&gt;」ならばX、それ以外 (nil を含む) ならば透明な画像を表示する。

という動作を行う仕組みができました。

テストとして、「C11」ウィジェットをクリックしてみてください。

![C11](images/032-click-C11.png =400x)

以下のように、「○」が表示されます。

![clicked at C11](images/033-clicked-C11.png =400x)

動作することを確認してください。

<a name="3x3"></a>
## C11を複製して3x3の升目を作る

動作することを確認した左上の升目を複製して、3x3の升目を作ります。
C11の右クリックメニューから「duplicate」を選択してください。

![duplicate](images/034-duplicate-C11.png =400x)

複製されたウィジェットの名前を指定します。
「C12」と入力してください。

![C12](images/035-duplicate-C12.png =400x)

「C12」ウィジェットが複製されました。

![C12](images/036-duplicated-C12.png =400x)

「C12」ウィジェットをドラッグして上段中央の升目に入れてください。

![move C12](images/037-moved-C12.png =400x)

これを繰り返して、全ての升目を埋めてください。

![C12-C33](images/038-duplicateAndMoveAll.png =400x)

LiveTalkブラウザでC12からC33までのスクリプトを作成します。
LiveTalkブラウザ上部のリストで LiveC11\`clicked を選択してください。
LiveTalkブラウザ下部に C11\`clicked のスクリプトが表示されるので、以下のように編集して、右クリックメニューでAcceptしてください。

```
C12`clicked
    play(1,2) -> [Status]
```

![C12 script](images/039-C12Script.png =400x)

同様に、C13\`clicked から C33\`clicked まで定義してください。

![C12 script](images/040-added-CScripts.png =400x)

Status\`assigned スクリプトを以下のように修正してください。

```
Status`assigned
    get(1,1) -> [C11]
    get(1,2) -> [C12]
    get(1,3) -> [C13]
    get(2,1) -> [C21]
    get(2,2) -> [C22]
    get(2,3) -> [C23]
    get(3,1) -> [C31]
    get(3,2) -> [C32]
    get(3,3) -> [C33]
```

![Status script](images/041-extend-StatusScript.png =400x)

<a name="start"></a>
## ゲーム開始ボタンを作る

最後に、盤面を初期化して Tic Tac Toe ゲームを開始するボタンを作成します。

ウィジェットパレットからButtonウィジェットをドラッグして、盤面の画像の下に置きます。

![Button](images/042-button.png =400x)

![Button placed](images/042-placed-Button.png =400x)

Buttonウィジェットの名前を「Start」に設定します。
右クリックメニューの「change name」を選択してください。

![change name](images/043-ChangeName-Button.png =400x)

新しいウィジェット名として「Start」と入力してください。

![Start](images/044-ChangeName-Start.png =400x)

![Start](images/045-changed-Start.png =400x)



![Start script](images/046-added-StartScript.png =400x)

Startボタンを押した時のアクションを定義します。

「LiveTalk」タブをクリックしてLiveTalkブラウザに切り替えてください。
LiveTalkブラウザ下部に以下のスクリプトを入力して、右クリックメニューから「Accept」してください。

```
Start`clicked
    reset()
    "" -> [Status]
```

これでUIの配置とスクリプトの定義が完了しました。

<a name="fix-position"></a>
## UIの配置を固定する

UIの配置が決まったら、配置を固定します。

C11ウィジェットの右クリックメニューで「fix position」を選択してください。
もしまた修正したい場合には、右クリックメニューで「make movable」を選択すると、固定が解除されるので、
修正して、再度「fix position」をしてください。

![fixposition](images/047-fixposition-widgets.png =400x)

<a name="play"></a>
## Tic Tac Toe をプレイしてみる

では、「Start」ボタンを押して、Tic Tac Toeで遊んでみましょう。

![start](images/048-click-Start.png =400x)

![play](images/049-click-C22.png =400x)

![play](images/050-computerMove.png =400x)

![play](images/051-player-move.png =400x)

![play](images/052-playout.png =400x)

![play](images/053-draw.png =400x)

引き分けました。Startボタンを押してリセットしてください。

![play](images/054-click-Start.png =400x)

盤面が初期化されました。
一通り遊ぶことができる UIプロトタイプ が完成しました。

![play](images/055-clicked-Start.png =400x)

UIプロトタイプが完成したことで、

* この通りの VDM-SL仕様は Tic Tac Toe ゲームに必要な機能を一通り備えていること
* この通りの UIデザインは Tic Tac Toe ゲームに必要な UI を一通り備えていること
* VDM-SL仕様 と UIデザインはお互いに想定が食い違っておらず、整合していること

が確認できました。
さらに洗練された VDM-SL仕様 と UIデザイン を得るために、VDM-SL技術者と UIデザイナがこのUIプロトタイプ上で議論して、
問題点、課題、改善できる点、設計として合意した点をまとめて、お互いに持ち帰りましょう。

<a name="save"></a>
## UIプロトタイプをファイルに保存する

作成した UIプロトタイプをファイルに保存します。

上端右側の「File」タブをクリックして「Save as...」ボタンを押してください。

![play](images/056-open-FileTag.png =400x)

ファイルダイアログが開くので、保存先のファイルを指定してください。

![play](images/057-SaveAs-TicTacToe-lwt.png =400x)

これでファイルに保存することができました。
開く時には、同じく「File」タブの「Load...」ボタンで、同じファイルを指定してください。

<a name="summary"></a>
## まとめ
このチュートリアルでは、あらかじめ用意されたVDM-SL仕様と盤面や石のUIデザインの素材を使って、コンピュータを相手に遊ぶ Tic Tac Toe ゲームの UI を構築し、VDM-SL仕様とUIを連携させることでプロトタイプを作成し、VDM-SL仕様についてUIデザイン上の妥当性と、UIデザインの機能上の妥当性を確認しました。

実際にシステムを開発する場合には、VDM-SL仕様の記述やUIデザインをそれぞれの専門の作業者が行う場合が多く、それぞれが前提としていることが食い違っていることもあります。Lively Walk-Through上で実際に動作する UIプロトタイプを作成し実際に使ってみることで、VDM-SL仕様とUIデザインが整合していることを確認し、それぞれVDM-SL仕様からプログラムの実装をする作業とUIデザインを完成させていきます。
