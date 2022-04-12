@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

function copy_files() {
    mkdir miniCommandPalette\work
    "dummy" > miniCommandPalette\work\dummy.txt # zip�� work/ ������p
    copy ..\README.md miniCommandPalette
    copy ..\src\minicommandpalette.mac miniCommandPalette\miniCommandPalette.mac # [���Y] �g�����X�p�C���̃^�C�~���O�ŏ������t�@�C�����ɂȂ�i�����炭�j
    copy ..\src\createlist.mac         miniCommandPalette\createList.mac
    copy ..\src\custom_sample.mac      miniCommandPalette
    copy ..\src\filterediting.mac      miniCommandPalette\filterEditing.mac
}

function compress() {
    Compress-Archive -Path miniCommandPalette -DestinationPath miniCommandPalette.zip
}

function main() {
    copy_files
    compress
    Remove-Item miniCommandPalette -Recurse
}


###
main
