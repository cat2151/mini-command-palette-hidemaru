// 簡易コマンドパレット用リスト生成
registerBuiltinFunction("disablehistory", "vn");
registerBuiltinFunction("currentmacrodirectory", "s");
registerBuiltinFunction("runex", "vsnnsnsnsnsnnnn");
registerBuiltinFunction("replaceallfast", "vssn");
registerBuiltinFunction("existfile", "ns");

function createMacroList(firstMacroDir: string, macs:string) {
  // マクロフォルダ配下のマクロファイル（*.mac）のリストを生成する
  var cmd = "cmd /c dir /s /b " + firstMacroDir + "\\..\\*.mac";
  runex(cmd
      , 1        //sync   0:async, 1:sync
      , 0, ""    //stdin  0:none, 1:auto, 2:<file, 3:(reserved),
                 //       4:current content, 5:selection
      , 2, macs  //stdout 0:none, 1:auto, 2:>file 3:>>file, 4:new window,
                 //       5:insert, 6:replace, 7:>output pane, 8:>>output pane
      , 0, ""    //stderr 0:none, 1:auto or >>stdout, 2-8:same as stdout's param
      , 0, ""    //folder 0:none, 1:current, 2:specify 3:(reserved), 4:exe's
      , 2        //show   0:auto, 1:show, 2:hide, 3-13:ShellExecute()'s SW_*
      , 1        //draw   0:draw, 1:no draw when stdout redirected
      , 0        //encode 0:ansi, 2:utf-16, 6:utf-8
      , 0);      //extended flags
}

function processMacroList(firstFilename: string, macs:string) {
  // ファイル名のリストを元に、マクロのリストを得る
  openfile("/h " + macs); // [備忘] noaddhist は、disablehistory(0x1FF); で代用する
  replaceallfast("^", "execmacro \"", 0x00000010/*regular*/); // よりよい方法があるか、hidescript.tsをregularで探した。もし今後builtinreplace系が実装されればより直感的に書ける可能性がある。
  replaceallfast("$", "\"", 0x00000010/*regular*/);
  replaceallfast("\\", "\\\\", 0x01000000/*1周する、ダミーとして指定*/); // よりよい方法があるか、hidescript.tsをregularで探した。もし今後builtinreplace系が実装されればダミー不要でより直感的に書ける可能性がある。
  save();
  setactivehidemaru(findhidemaru(firstFilename));
  closehidemaru(findhidemaru(macs));
}

function createCustomList(customSample: string, customName: string) {
  // custom.macが存在しなかった場合、custom_sample.macからコピーする
  // 想定しているタイミングは、インストール直後、work/list.mac がなく当マクロが呼ばれたタイミング
  if (existfile(customName)) return;
  var cmd = "cmd /c copy " + customSample + " " + customName;
  runex(cmd
      , 1     //sync   0:async, 1:sync
      , 0, "" //stdin  0:none, 1:auto, 2:<file, 3:(reserved),
              //       4:current content, 5:selection
      , 0, "" //stdout 0:none, 1:auto, 2:>file 3:>>file, 4:new window,
              //       5:insert, 6:replace, 7:>output pane, 8:>>output pane
      , 0, "" //stderr 0:none, 1:auto or >>stdout, 2-8:same as stdout's param
      , 0, "" //folder 0:none, 1:current, 2:specify 3:(reserved), 4:exe's
      , 2     //show   0:auto, 1:show, 2:hide, 3-13:ShellExecute()'s SW_*
      , 1     //draw   0:draw, 1:no draw when stdout redirected
      , 0     //encode 0:ansi, 2:utf-16, 6:utf-8
      , 0);   //extended flags
}

function mixList(firstMacroDir: string, customName: string, macs: string, total: string) {
  // 各ファイルを連結し、コマンドパレット用のリストを得る
  var cmd = "cmd /c copy " + customName + "+" + macs + " " + total;
  runex(cmd
      , 1     //sync   0:async, 1:sync
      , 0, "" //stdin  0:none, 1:auto, 2:<file, 3:(reserved),
              //       4:current content, 5:selection
      , 0, "" //stdout 0:none, 1:auto, 2:>file 3:>>file, 4:new window,
              //       5:insert, 6:replace, 7:>output pane, 8:>>output pane
      , 0, "" //stderr 0:none, 1:auto or >>stdout, 2-8:same as stdout's param
      , 0, "" //folder 0:none, 1:current, 2:specify 3:(reserved), 4:exe's
      , 2     //show   0:auto, 1:show, 2:hide, 3-13:ShellExecute()'s SW_*
      , 1     //draw   0:draw, 1:no draw when stdout redirected
      , 0     //encode 0:ansi, 2:utf-16, 6:utf-8
      , 0);   //extended flags
  if (!existfile(total)) {
      message("ERROR : リスト生成に失敗しました");
      endmacro();
  }
}

function main() {
  disablehistory(0x1FF);

  var firstFilename = filename();
  var firstMacroDir = currentmacrodirectory();
  var macs          = firstMacroDir + "\\work\\macroFiles.mac";
  var customSample  = firstMacroDir + "\\custom_sample.mac";
  var customName    = firstMacroDir + "\\custom.mac";
  var total         = firstMacroDir + "\\work\\list.mac";

  createMacroList(firstMacroDir, macs);
  processMacroList(firstFilename, macs);
  createCustomList(customSample, customName);
  mixList(firstMacroDir, customName, macs, total);
}


//
main();
