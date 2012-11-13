vimrc for UNIX Web Developers (PHP/C/C++/Lua/JavaScript/HTML/CSS)
============


Goal
----------------
This vimrc aimes to collect some useful plugins for web developers working under UNIX and using PHP, C/C++, Lua, JavaScript, etc.

This is based on brooky-yen''s vimrc (https://github.com/brooky-yen/vimrc)
I adjust the bundle list for this vimrc to focus on web development, and share with my colleagues.

I also added the chinese help documentation of VIM 7.2, see by type `:h`.

Author: hightman <hightman@twomice.net>


Requisites
----------------
The distribution is designed to work with Vim >= 7.2.

The distribution also requires ack, ctags, git, ruby and rake. I recommend using the GUI version of VIM (gvim on Linux and Windows, MacVim on OSX) for some plugin only support GUI version (e.g. Command-T). You can [download MacVim here](https://github.com/b4winckler/macvim/downloads).


Useful vim Plugins included
----------------
 * [vim-autoclose](https://github.com/Townk/vim-autoclose)
 * [ack.vim](https://github.com/mileszs/ack.vim)
 * [vim-bufexplorer](https://github.com/thisivan/vim-bufexplorer)
 * [vim-easytag](https://github.com/xolox/vim-easytags)
 * [tagbar](https://github.com/majutsushi/tagbar)
 * [tagbar-phpctags](https://github.com/techlivezheng/tagbar-phpctags)
 * [nerdtree](https://github.com/scrooloose/nerdtree)
 * [nerdcommenter.git](https://github.com/scrooloose/nerdcommenter.git)
 * [YankRing.vim.git](https://github.com/vim-scripts/YankRing.vim.git)
 * [vim-fugitive](https://github.com/tpope/vim-fugitive)
 * [vim-repeat](https://github.com/tpope/vim-repeat)
 * [vim-surround](https://github.com/tpope/vim-surround)
 * [vim-eunuch](https://github.com/tpope/vim-eunuch)
 * [vim-markdown](https://github.com/tpope/vim-markdown)
 * [vim-endwise](https://github.com/tpope/vim-endwise)
 * [xmledit.git](https://github.com/sukima/xmledit.git)
 * [matchit.zip](https://github.com/vim-scripts/matchit.zip)
 * [vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
 * [neocomplcache](https://github.com/Shougo/neocomplcache)
 * [neosnippet](https://github.com/Shougo/neosnippet)
 * [OmniCppComplete](https://github.com/vim-scripts/OmniCppComplete)
 * [syntastic](https://github.com/scrooloose/syntastic)
 * [vim-php-cs-fixer](https://github.com/stephpy/vim-php-cs-fixer)
 * [vim-php-namespace](https://github.com/arnaud-lb/vim-php-namespace)
 * [phpcomplete.vim](https://github.com/shawncplus/phpcomplete.vim)
 * [php.vim](https://github.com/shawncplus/php.vim)
 * [PDV--phpDocumentor-for-Vim](https://github.com/vim-scripts/PDV--phpDocumentor-for-Vim)
 * [vim-html5-fix](https://github.com/concise/vim-html5-fix)
 * [vim-haml](https://github.com/tpope/vim-haml)
 * [vim-javascript](https://github.com/pangloss/vim-javascript)
 * [vim-jquery](https://github.com/itspriddle/vim-jquery)
 * [php-search-doc](https://github.com/erikfercak/php-search-doc)
 * [vim-jquery-doc](https://github.com/lucapette/vim-jquery-doc)
 * [ctrlp.vim](https://github.com/kien/ctrlp.vim)


INSTALL
-------

1. clone this vimrc
    ```
    git clone https://github.com/hightman/vimrc.git
    ```

2. Run the install script
    ```
    sh vimrc/install.sh
    ```

    > Notice: This step may cost much longer time for configuring & install bundles.

3. Finished! Enjoy it :-)


Conventions
------------

* Backup enabled, the BAK file is saved as `~/.vim/bak/$NAME~`

* Swap file is moved to `~/.vim/tmp/$NAME.swp`

* Shourtcuts, the `<leader>` key is `;`
  - `;w` Save & quit
  - `;q` Force to quit without saving
  - `;r` Replace the current word in all opened files
  - `;er` Open the error console
  - `;p` Toggles pastle mode with normal mode
  - `;g` Include guard for C source/header file
  - `;s` Clear search highlighting
  - `;b` Open the BufExplorer in current window
  - `+` `-` Quickly adjust size of current splitted window
  - `Shift-W` Loop to switch splitted window
  - `Ctrl-J Ctrl-K` Move to below/above splitted window and maxmize it
  - `Ctrl-H Ctrl-L` Move to left/right splitted window and maxmize it under normal mode
  - Double press `Ctrl-T` to open new tab
  - `Ctrl-T` + `Ctrl-W` to open the current tab
  - `:cd.` Change the working directory to that of the current file
  - `Ctrl-[` `Ctrl-]` `Ctrl-\` Jump/Back out of the tag stack 
  - `F7` `;t` Toggle Tagbar
  - `F3` `;n` Toggle NerdTree Tabs
  - `F6` `;sy` Manually Syntax check by syntastic plugin
  - `F2` `;y` Open yanking history
  - `;pm` `;pf` `;jm` Open online PHP_Manual, PHP_Function, JQuery_Manual
  - `Ctrl-P` `;f` Invoke CtrlP to find files
  - `;ut` `;ht` Update/Highlight tags by vim-easytags


