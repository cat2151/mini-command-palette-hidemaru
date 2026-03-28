# mini command palette hidemaru

A simple command palette. (Experimental stage)

# Features
- Macro File List
  - Automatically generates a list of macro files, allowing you to select and execute any of them. No need to assign keys to macro files.
- Command Palette
  - Similar to VSCode's command palette (or a browser's address bar), you can narrow down the display of target macro files by typing a few characters, then select one with the arrow keys and confirm with ENTER.
- Incremental Search and Filtering
  - As you type, you can narrow down and display the target lines.
- AND Search
  - You can filter by AND search by separating keywords with spaces.
- Migemo
  - For example, typing `siyou` can filter for words like 「使用」(usage) and 「仕様」(specifications).
- Customization
  - You can freely add lines.
  - Aliases
    - For example, you can assign custom aliases to macros.
    - You can use Migemo to assign Japanese aliases to macros.
  - Generation
    - You can generate and add lists, similar to the macro list.
- Filtering and Jumping in Currently Edited Files
  - You can filter currently edited files using Migemo or AND search, and jump to the selected line.

# What makes it easier?
- Just Type
  - Simply place macro files and filter them from the command palette to use them.
  - You don't need to remember key assignments for each macro, which is convenient.
- Just Register Easily Remembered Words as Aliases
  - For example, suppose you have a macro to insert today's weather and another to insert today's news, and you've registered aliases like '今日の天気' (Today's Weather) and '今日のニュース' (Today's News) in the customization file.
    - You can use them intuitively by typing 'tenki', 'news', 'nyu-su', etc.
  - This is powerful when you might forget which key or menu a macro is assigned to.
  - It might be useful if you want to recall and use macros quickly with your own aliases, or if you frequently use a macro but finding it is tedious, so you want an alias that's easy to filter.
  - We consider this alias usage to be in an experimental stage.
    - For example, I am not aware if there are cases where VSCode uses aliases in this manner, due to my lack of knowledge.
    - As a similar example, [afxfazzy](https://github.com/yuratomo/afxtools), which inspired this project, has achieved significant results in my own operational use.
      - Therefore, I believe such usage might also be valid for text editors.
- Multi-stage Filtering of Currently Edited Files
  - You can list multiple search results like grep, dynamically change search conditions like incremental search, and also use Migemo and AND search.
  - For example, it's easy to filter error lines from a log file and then further refine the search with an AND query.

# Supplementary Feature Descriptions
- Listing Macro Files
  - Registers them in the command palette list on first launch.
  - Subsequently, you can update the list by selecting 'Reload' from the command palette.
  - The list is maintained independently by the command palette. Rest assured, it does not affect Hidemaru's settings.
- Concatenating Customization List and Macro File List
  - Concatenated upon reload.
  - If the customization list does not exist, it will be copied from `custom_sample.mac`.

# Requirements
- Windows 64bit
- Wait from execution until the window appears (typing before the window appears will not activate it).
- A playful spirit
  - Since it's still in the experimental stage, there are challenges (described later). A playful spirit is required to use it.

# Install
- Download
  - In your Hidemaru macro directory, paste the following into the command prompt and press ENTER:
  ```
  curl.exe -L https://raw.githubusercontent.com/cat2151/mini-command-palette-hidemaru/main/install/installMiniCommandPalette.bat --output installMiniCommandPalette.bat && installMiniCommandPalette.bat
  ```
- Macro Registration
  - Open Hidemaru and navigate to `Menu / Macro / Macro Registration`.
  - In an empty slot from Macro 1 to Macro 80, register the following macro:
    - Title :
      - `Command Palette`
    - Filename :
      - `miniCommandPalette\miniCommandPalette.mac`
- Key Assignment
  - Open Hidemaru's `Menu / Others / Key Assignment` screen.
  - On the `Command to Key` tab, check `Shift` and `Ctrl` in the bottom left.
  - Assign 'Macro xx : Command Palette' to `Shift + Ctrl + P`. (xx is a number from 1 to 80)
- Test
  - Press `Shift + Ctrl + P` and confirm that the command palette screen opens.
  - Select `Customize Command Palette`, press ENTER, and confirm that `custom.mac` opens.
- To update
  - Simply perform the `Download` step again. (Don't worry, it won't overwrite your configuration files.)

# Tutorial
- Customization
  - Open Hidemaru.
  - Press `CTRL + SHIFT + P`.
  - Select `Customize Command Palette`.
  - Confirm that `custom.mac` opens.
  - Add the following line:
    ```
    /* こんにちは */ message "hello, world";
    ```
  - Press `CTRL + SHIFT + P`.
  - Select `Reload Command Palette`.
  - Confirm that `/* こんにちは */ message "hello, world";` has been added.
  - Select `/* こんにちは */ message "hello, world";`.
    - Type `kon` or `hel` to confirm that you can select it using both Japanese and English input.
  - Confirm that the dialog `hello, world` is displayed.
- Filtering Currently Edited Files
  - In Hidemaru, open a log file with errors, for example.
  - Press `CTRL + SHIFT + P`.
  - Select `Filter Current File`.
    - It's easier to select by typing `he`, `fa`, or `si` (Migemo for '編集中' (editing), 'ファイル' (file), '絞り込み' (filter), respectively).
  - Type `error`.
  - Confirm that `ERROR`, `error`, `エラー`, etc., are filtered (Migemo matches `エラー` as well).
  - Select a line and press `ENTER`.
  - Confirm that you jumped to that line.

# Future Plans
- The following features might be useful. They might be implemented, or they might not.
  - List of 'Hidemaru's built-in functions'
  - List of 'Recently edited files'
  - List of bookmarks

# Challenges

## Not as feature-rich as VSCode's Command Palette
- It lacks history, the ability to match by continuously typing the beginning or parts of words without spaces, and action switching via prefixes like `>` or `@`. It does not have the extensive features of VSCode's command palette.
- This is because it is in an experimental stage.
- Whether features will be added in the future is undecided. They might not be.

## Macro File List uses full paths, making selection difficult
- Countermeasures are under consideration.
  - Proposed solutions :
    - When generating the list, insert the macro filename at the beginning, like `/* foo.mac */`, using a script.

## To speed up startup
- It might be faster if it could be made resident using tkinter's minimization-related features and Hidemaru macro's Windows-related features. (Whether this is possible is unknown.)
- It would likely be faster if built with VC++. Reference: [afxfazzy](https://github.com/yuratomo/afxtools)
- It would likely be faster if created as a DLL plugin for a text editor.
- When it will be created is undecided. It might not be created.

## Name is too long and cumbersome
- If a VC++ or text editor plugin version can be created, a shorter name might be considered then.