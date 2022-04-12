@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

function install_miniCommandPalette() {
    curl.exe -L https://github.com/cat2151/mini-command-palette-hidemaru/releases/download/v1.1.0/miniCommandPalette.zip --output miniCommandPalette.zip
    Expand-Archive -Path miniCommandPalette.zip -DestinationPath . -Force
    del miniCommandPalette.zip
}

function install_miniIncrementalSearchFilter() {
    pushd miniCommandPalette
    curl.exe -L https://github.com/cat2151/mini-incremental-search-filter/releases/download/v1.0.0/miniIncrementalSearchFilter.zip --output miniIncrementalSearchFilter.zip
    Expand-Archive -Path miniIncrementalSearchFilter.zip -DestinationPath . -Force
    del miniIncrementalSearchFilter.zip
    popd
}

function install_migemo() {
    pushd miniCommandPalette\miniIncrementalSearchFilter
    curl.exe -L https://raw.githubusercontent.com/cat2151/migemo-auto-install-for-windows/main/install_cmigemo.bat --output install_cmigemo.bat
    cmd /c install_cmigemo.bat
    popd
}

function main() {
    install_miniCommandPalette
    install_miniIncrementalSearchFilter
    install_migemo
    del installMiniCommandPalette.bat # �������g���폜����
}


###
main
