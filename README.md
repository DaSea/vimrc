**主要保存使用的vim/neovim配置，zsh, bash, tmux等配置**

## vim
已经移动到[dotfiles](https://github.com/DaSea/dotfiles/tree/master/vim)

### 各个文件的作用
* .vimrc 主要的入口
* .vimrc.vimplug 记录通用的插件，主要有exvim系列插件，其他等~
* .vimrc.language 与语言相关的放在这个文件
  - 如果需要扩展语言相关，在此添加
* .vimrc.complete 补全的，通用的
  - 对于vim, 如果支持python, 则使用ycm补全插件
  - 对于nvim, 使用deoplete.nvim
* .vimrc.ctrlp 放ctrlp与NERDTree配置
* .vimrc.unitvim 放unit.vim, denite.nvim与vimfiler相关配置，
* .vimrc.statusline 配置lightline.vim 和vim-airline
* .vimrc.discard 放暂时废弃不用的插件及配置，防止以后后悔了加进来

### 常用快捷键
#### 窗口及buffer 操作
```
<Leader>jw
<Leader>kw
<Leader>hw
<Leader>lw : 上面四个分割窗口，并跳到相应的窗口

<Leader>wj
<Leader>wk
<Leader>wh
<Leader>wl : 分别跳转到相应窗口

<Leader>mc : 关闭窗口
<Leader>mq : 关闭buffer而不关闭窗口
```

#### 文件及buffer操作
```
<Leader>jf : mru窗口

<Leader>lf
ctrl + p   : 快速查找文件

<Leader>fl : 快速跳转buffer

<Leader>fm : outline

<Leader>of : 打开文件管理器，并选中文件
```

#### markdown
`
<Leader>mp  : 在浏览器中预览markdown,前提是浏览器安装了可以预览markdown的插件
`


#### plantuml
```
<Leader>um  : 在当前buffer的上面生成一个ASCII画
<Leader>up  : 生成image图片,需要plantuml.jar支持
```

#### 翻译
```
<Leader>yd  ：翻译当前光标下或被选中单词，并在命令行回显
<Leader>yi  : 翻译命令行输入的单词
<Leader>yw  : 翻译当前光标或被选中的单词，并在单独的窗口显示
<Leader>yr  : 翻译当前光标或被选中的内容，并替换
```

## shell

### zsh
**需要安装on-my-zsh**

### bash
**配合bash-it使用**

