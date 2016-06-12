mkdir -p ~/mb/Laniakea/webus
meteor build --architecture=os.linux.x86_64  ~/mb/Laniakea/webus
scp -P 23 ~/mb/Laniakea/webus/webus.tar.gz root@119.254.97.226:/mb/Laniakea/webus/webus.tar.gz
ssh -p 23 root@119.254.97.226
