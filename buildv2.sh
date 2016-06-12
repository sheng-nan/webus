mkdir -p ~/mb/Laniakea/webusv2
meteor build --architecture=os.linux.x86_64  ~/mb/Laniakea/webusv2
scp  ~/mb/Laniakea/webusv2/webus.tar.gz root@119.254.97.226:/mb/Laniakea/webusv2/webusv2.tar.gz
ssh  root@119.254.97.226
