##1.搭建Dokcer开发环境

#### - 切换到kslab-server的同级目录，拉去docker 相关脚本文件,cd ..

#### - git clone git@172.16.0.129:/home/git/kslab-docker

#### - 安装docker服务

#### - 安装docker-compose

#### - 回到kslab-server目录执行docker-compose up -d

##2.搭建Laravel开发环境

#### - git clone git@172.16.0.129:/home/git/kslab-server

#### - cd ~/kslab-server 切换到larave框架目录

#### - cp .env.example .env 把环境文件.env.example 复制一份为.env

#### - 运行 composer update

#### - 运行 php artisan storage:link

#### - 打开hosts文件，在末尾追加一条记录
##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;172.16.0.129. server.kslab.com
##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;172.16.0.129. test.kslab.com

#### - 浏览器地址输入server.kslab.com或者test.kslab.com即可访问
