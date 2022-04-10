@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

function install_miniCommandPalette() {
    curl.exe -L https://github.com/cat2151/mini-command-palette-hidemaru/releases/download/v1.0.0/miniCommandPaletteHidemaru.zip --output miniCommandPaletteHidemaru.zip
    Expand-Archive -Path miniCommandPaletteHidemaru.zip -DestinationPath . -Force
    del miniCommandPaletteHidemaru.zip
}

function install_miniIncrementalSearchFilter() {
    pushd miniCommandPaletteHidemaru
    curl.exe -L https://github.com/cat2151/mini-incremental-search-filter/releases/download/v1.0.0/miniIncrementalSearchFilter.zip --output miniIncrementalSearchFilter.zip
    Expand-Archive -Path miniIncrementalSearchFilter.zip -DestinationPath . -Force
    del miniIncrementalSearchFilter.zip
    popd
}

function install_migemo() {
    pushd miniCommandPaletteHidemaru\miniIncrementalSearchFilter
    curl.exe -L https://raw.githubusercontent.com/cat2151/migemo-auto-install-for-windows/main/install_cmigemo.bat --output install_cmigemo.bat
    install_cmigemo.bat
    popd
}

function main() {
    install_miniCommandPalette
    install_miniIncrementalSearchFilter
    install_migemo
#    del installMiniCommandPalette.bat
}


###
main
