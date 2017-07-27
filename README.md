# ctrlp-vimshell.vim

Execute vimshell history by ctrlp interface.

Dependence: [vimshell](https://github.com/Shougo/vimshell.vim) and [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)

vimshell is a amazing shell for vim. I like it, But some of its function are depending on other plugin like [unite.vim](https://github.com/Shougo/unite.vim).

List command history is one of basic function of a shell, here I use ctrlp interface to implement this feature.


Add following keymappng to your vimrc.


```vim
au FileType vimshell :imap <buffer> <c-k> <c-o>:stopinsert<cr>:call ctrlp#vimshell#start()<cr> 
au FileType vimshell :imap <buffer> <up> <c-o>:stopinsert<cr>:call ctrlp#vimshell#start()<cr>
```

Press `Enter` in ctrlp window will execute the selected command immediately.

Press `Ctrl-x` in ctrlp window  will insert the command string only.
