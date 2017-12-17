#!/bin/zsh
./configure --with-features=huge \
    --with-compiledby=$USER \
    --enable-multibyte \
    --enable-luainterp \
    --with-luajit --with-lua-prefix=/usr \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
    --enable-terminal \
    --with-x \
    --enable-gui=gtk2 \
    --enable-cscope \
    --enable-fail-if-missing \
    --prefix=/usr/local

    # --enable-pythoninterp=yes \
    # --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
# --enable-python3interp \
    # --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
# 编译着的用户名
# --with-compiledby="YourName" or $USER
#
# --with-features=huge：支持最大特性
#
# python 2支持
# --enable-pythoninterp=yes
# --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu
# python3 同理
# --enable-python3interp \
    # --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
# perl 支持
# --enable-perlinterp=yes
# ruby支持
# --enable-rubyinterp=yes
# 需要安装lua lua-dev luajit libluajit
# --with-luajit
# --enable-luainterp=yes --with-lua-prefix=/usr
# 安装libxt-dev 开启clipboard支持
# --with-x
# --enable-fail-if-missing
# --enable-rubyinterp：启用Vim对ruby编写的插件的支持
# --enable-luainterp：启用Vim对lua编写的插件的支持
# --enable-perlinterp：启用Vim对perl编写的插件的支持
# --enable-multibyte：多字节支持 可以在Vim中输入中文
# --enable-cscope：Vim对cscope支持
# --enable-gui=gtk2：gtk2支持,也可以使用gnome，表示生成gvim, 需要libgtk2.0-dev支持
# --with-python-config-dir=/usr/lib/python2.7/config-i386-linux-gnu/ 指定 python 路径
# --prefix=/usr：编译安装路径

#make clean
# make VIMRUNTIMEDIR=/usr/share/vim/vim80
# make install
