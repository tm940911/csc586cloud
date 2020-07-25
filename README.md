# csc586cloud V2

setup crontab entries based on picture

##### observer:

`sudo vi /etc/exports` and add `/var/webserver_monitor/ 192.168.1.1(rw,sync,no_root_squash,no_subtree_check)`

sudo systemctl restart nfs-kernel-server

https://hostadvice.com/how-to/how-to-setup-postfix-as-send-only-mail-server-on-an-ubuntu-18-04-dedicated-server-or-vps/

##### webserver:

sudo mount 192.168.1.2:/var/webserver_monitor /var/webserver_log
