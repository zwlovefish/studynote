# centos安装mysql
1. \# wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
2. \# rpm -ivh mysql-community-release-el7-5.noarch.rpm
3. \# yum install mysql-server
4. \# mysql
5. mysql>  set password for root@localhost = password("123456")
6. mysql>flush privileges
7. mysql>grant all privileges on \*.\* to 'root'@'%' identified by '123456' with grant option
8. mysql>privileges