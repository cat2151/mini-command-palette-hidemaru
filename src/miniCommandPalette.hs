// 簡易コマンドパレット（実験的）
// 開発には https://github.com/cat2151/hidescript/blob/v1.1.0/hidescript/hidescript.ts を使いました
registerBuiltinFunction("disablehistory", "vn");
registerBuiltinFunction("currentmacrodirectory", "s");
registerBuiltinFunction("existfile", "ns");
registerBuiltinFunction("execmacro", "vs");
registerBuiltinFunction("deletefile", "vs");
registerBuiltinFunction("runex", "vsnnsnsnsnsnnnn");

function selectMacro(macroDir: string, total: string, macName: string, migemoDict: string) {
  var exeName = macroDir + "\\miniIncrementalSearchFilter\\miniIncrementalSearchFilter.exe";
  var cmd = exeName + " " + total + " " + macName + " --encode cp932 --andsearch --migemo " + migemoDict + " --alpha 0.96 --width 150 --height 40";
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

function main() {
  disablehistory(0x1FF);

  var macroDir   = currentmacrodirectory();
  var total      = macroDir + "\\work\\list.mac";
  var macName    = macroDir + "\\work\\result.mac";
  var migemoDict = macroDir + "\\miniIncrementalSearchFilter\\dict\\migemo-dict";

  if (!existfile(total)) {
    execmacro(macroDir + "\\createList.mac");
  }
  deletefile(macName); // キャンセル時に前回のファイルを実行しない用
  selectMacro(macroDir, total, macName, migemoDict);
  if (existfile(macName)) {
    execmacro(macName);
  }
}


//
main();
