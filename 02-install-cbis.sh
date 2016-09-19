#!/usr/bin/bash
#
# Install the CBIS undercloud
# Joey <joey.mcdonald@nokia.com>

source local-settings.sh

release=$1
build=$2

working_dir="cbis-$1-$2"

echo "$release" > db/release.txt
echo "build" > db/localbuild.txt
cd $working_dir

function check_for_libvirt() {

   rpm -q libvirt &> /dev/null
   if [ $? != '0' ]; then
      echo "FATAL: You don't have libvirt installed."
      echo "You can try: yum groupinstall 'Virtualization Host'"
      exit 127
   fi 
}

function check_for_nfs() {


   rpm -q nfs-utils &> /dev/null 
   if [ $? != '0' ]; then
      echo "FATAL: You don't have nfs software installed."
      echo "You can try: yum install nfs-utils"
      exit 127
   fi 

   # If you got this far, good job. Try this:
   # yum -y install nfs-utils
   # systemctl enable rpcbind
   # systemctl enable nfs-server
   # systemctl enable nfs-lock
   # systemctl enable nfs-idmap
   # systemctl start rpcbind
   # systemctl start nfs-server
   # systemctl start nfs-lock
   # systemctl start nfs-idmap
   # firewall-cmd --permanent --zone=public --add-service=nfs
   # firewall-cmd --reload

}

function unpack_archive() {

   echo -n "Uncompressing CBIS artifact: "
   tar -zxf cbis-installer.tar.gz
   echo "Ok"
}

function update_config() {

   echo -n "Updating undercloud configuration: "
   cd cbis-installer/

   sed -i "s/<public_ip_address>/$UC_PUBLIC_IP/" config.yaml
   sed -i "s/<public_gateway>/$UC_PUBLIC_GW/" config.yaml
   sed -i "s/<public_netmask>/$UC_NETMASK/" config.yaml
   sed -i "s/<dns_server>/$UC_DNS/" config.yaml
   sed -i "s/<ntp_server>/$UC_NTP/" config.yaml

   sed -i "s/<hypervisor_ip>/$HYPERVISOR_IP/" config.yaml
   sed -i "s/<public_interface>/$HYPERVISOR_PUBLIC_INTERFACE/" config.yaml
   sed -i "s/<private_interface>/$HYPERVISOR_PRIVATE_INTERFACE/" config.yaml
   echo "Ok"
}

function install_undercloud() {

   python ./install_undercloud.py
}

check_for_libvirt
unpack_archive
update_config
install_undercloud
