## 安装和配置git
sudo apt-get install git

git config --global user.name "周健伟"

git config --global user.email "1149610059@qq.com"

ssh-keygen -C 'you email address@gmail.com' -t rsa

cd ~/.ssh

vim id_rsa.pub将里面所有的内容复制粘贴到github.com的网站中

## 上传到远程仓库
git init

git add ./要上传的文件夹

git commit -m "注释"

git remote add origin 地址

git push -u origin 分支名