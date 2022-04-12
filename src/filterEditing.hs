// 編集中ファイルを絞り込みし、選んだ行へジャンプする（重複行の場合はその1つめにジャンプする）
// 開発には https://github.com/cat2151/hidescript/blob/v1.1.0/hidescript/hidescript.ts を使いました
registerBuiltinFunction("disablehistory", "vn");
registerBuiltinFunction("filename2", "s");
registerBuiltinFunction("currentmacrodirectory", "s");
registerBuiltinFunction("deletefile", "vs");
registerBuiltinFunction("existfile", "ns");
registerBuiltinFunction("runex", "vsnnsnsnsnsnnnn");
registerBuiltinFunction("copyline", "v");
registerBuiltinFunction("beginclipboardread", "v");
registerBuiltinFunction("getclipboard", "s");
registerBuiltinFunction("encode", "n");
registerBuiltinFunction("moveto", "vnn");
registerBuiltinFunction("y", "n");

function getEncode() : string {
  if (encode() == 1/*Shift-JIS*/) return "cp932";
  if (encode() == 6/*UTF-8    */) return "utf_8";
  message("ERROR : encode [" + str(encode()) + "]");
  endmacro();
}

function filterEditing(macroDir: string, input: string, resultName: string, migemoDict: string, encode: string) {
  var exeName = macroDir + "\\miniIncrementalSearchFilter\\miniIncrementalSearchFilter.exe";
  var cmd = exeName + " " + input + " " + resultName + " --encode " + encode + " --andsearch --migemo " + migemoDict;
  runex(cmd
      , 1     //sync   0:async, 1:sync
      , 0, "" //stdin  0:none, 1:auto, 2:<file, 3:(reserved),
              //       4:current content, 5:selection
      , 0, "" //stdout 0:none, 1:auto, 2:>file 3:>>file, 4:new window,
              //       5:insert, 6:replace, 7:>output pane, 8:>>output pane
      , 0, "" //stderr 0:none, 1:auto or >>stdout, 2-8:same as stdout's param
      , 0, "" //folder 0:none, 1:current, 2:specify 3:(reserved), 4:exe's
      , 0     //show   0:auto, 1:show, 2:hide, 3-13:ShellExecute()'s SW_*
      , 0     //draw   0:draw, 1:no draw when stdout redirected
      , 0     //encode 0:ansi, 2:utf-16, 6:utf-8
      , 0);   //extended flags
}

function jump(resultName: string, firstFilename: string) {
  // 結果fileの先頭行をクリップボードへ
  openfile("/h " + resultName); // [備忘] noaddhist は、disablehistory(0x1FF); で代用する
  copyline();
  // 結果fileを閉じる
  setactivehidemaru(findhidemaru(firstFilename));
  closehidemaru(findhidemaru(resultName));
  // クリップボードを元に検索する
  moveto(0, 0);
  beginclipboardread();
  searchdown(getclipboard());
  // 範囲選択解除する
  moveto(0, y());
}

function main() {
  disablehistory(0x1FF);

  var firstFilename = filename2();
  var macroDir      = currentmacrodirectory();
  var resultName    = macroDir + "\\work\\result_filterEditing.mac";
  var migemoDict    = macroDir + "\\miniIncrementalSearchFilter\\dict\\migemo-dict";

  deletefile(resultName); // キャンセル時に前回のファイルを実行しない用
  filterEditing(macroDir, firstFilename, resultName, migemoDict, getEncode());
  if (existfile(resultName)) {
    jump(resultName, firstFilename);
  }
}


//
main();
