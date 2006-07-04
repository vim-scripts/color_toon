"color_toon.vim -- colorscheme toy
" Maintainer:   Walter Hutchins
" Last Change:  July 04 2006
" Version:      1.0
" Setup:        Copy color_toon.vim to ~/.vim/plugin/
"               Copy light.vim to ~/
"               Copy dark.vim to ~/
"               Windows - adjust: first, last, myjunk  | adjust plugin location
"
" Thanks to: colortest
" Thanks to: Tip #634: To view all colours 
"Use without any expectations.
"Please liberally use :qa! and :q! whenever you like.
"
"The only recommended use of :w! is to write over your 'myjunk.vim'.
"If you happen to get a color scheme, copy 'myjunk.vim' to 'myugly.vim'
"or whatever. Then stick 'let colors_name="myugly"' in myugly.vim.
"If myjunk.vim gets to where you don't like it anymore, then delete it
"and it will be created from your default colorscheme (maybe).
"Usage: Colortoon
"       Colortoon -dark
"       call Color_toon()
"Somethings: to do are:
"Scroll up and down in the 'dark' and 'light' windows to see what the
"cterm and gui numbers are for the colors.
"Scoll up and down in the 'Highlight test' window to see samples of the
"current colors of the highlighting groups.
"Go in the 'myjunk.vim' window and make changes.
"For example: See a 'pretty' color and want to make the Normal text look
"like that, position to the line starting with 'hi Normal' and change the
"ctermfg to the cterm_number seen in the color window -- also to change
"the guifg to the gui_number of that same color.
"(guifg's and guibg's start with a '#' | ctermfg's and ctermbg's do not.)
"Now, select the whole line you just edited (starts with 'hi '), 
"type : to go into command mode, paste with the mouse, and hit enter.
"You should see the new highlighting.
"Oops: can't help it:
"Yes, when you start up Colortoon, there will be an error -- too many 
"highlighting groups while it is trying to show the colors in the 
"light and dark windows.  It stumbles after around 200th one encountered. 
"If you need to see the rest of dark ones, say 'Colortoon -dark'. 
"May need to completely get out of all windows before it will show 
"different ones (this is a funny thing.)
"Remember to use :qa! and :q! whenever you like -- to bail out.
command -nargs=* Colortoon call Color_toon(<f-args>)
function Color_toon(...)
let choice="light"
if a:0 > 0
    if a:1 ==? "dark" || a:1 =~? "^-d"
        let choice="dark"
    endif
endif
let myjunk='~/.vim/colors/myjunk.vim'
let first='~/light.vim'
let last='~/dark.vim'
if exists("choice")
    if choice ==? "dark"
        let first='~/dark.vim'
        let last='~/light.vim'
    endif
endif
"Current highlighting specs
colo myjunk
set hidden lazyredraw nomore report=99999 shortmess=aoOstTW wrapscan
new
exec 'edit ' myjunk
1,$d
redir @a
hi
redir END
put a
%s/^.*links to.*$//
%s/xxx//
g/^$/d
g/^cterm_\d\+/d
g/\(\n\)\s\+/j
%s/^/hi /
1

"Current highlighting test
so $VIMRUNTIME/syntax/hitest.vim

"Colors choices to look at
"First colors - 1st ~ 200 display actual color
new
exec 'edit ' first
g/^cterm_\d\+/ exec 'hi col_'.expand("<cword>").' ctermfg='.strpart(expand("<cword>"),6).' guifg=#'.strpart(expand("<cword>"),strlen(expand("<cword>"))-6)| exec 'syn keyword col_'.expand("<cword>")." ".expand("<cword>")
1
"Last colors - ones beyond ~ 200th will display random colors
vnew
exec 'edit ' last
g/^cterm_\d\+/ exec 'hi col_'.expand("<cword>").' ctermfg='.strpart(expand("<cword>"),6).' guifg=#'.strpart(expand("<cword>"),strlen(expand("<cword>"))-6)| exec 'syn keyword col_'.expand("<cword>")." ".expand("<cword>")
1
endfunction
