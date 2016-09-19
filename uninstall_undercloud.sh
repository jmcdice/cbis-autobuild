#!/bin/bash

umount /mnt/live > /dev/null 2>&1 || /bin/true

virsh list --all | grep undercloud
if [ $? -eq 0 ]; then
    virsh destroy undercloud
    virsh undefine undercloud
    rm -f /var/lib/libvirt/images/undercloud.qcow2
    echo "The undercloud was successfully deleted"
else
    rm -f /var/lib/libvirt/images/undercloud.qcow2
    echo "No undercloud found"
fi

PUBLIC_IP=$(grep UC_PUBLIC_IP local-settings.sh |perl -lane 'print $1 if (/\x27(.*?)\x27/)')
if [ -n "$PUBLIC_IP" ]; then
    ssh-keygen -R $PUBLIC_IP > /dev/null 2>&1
    ssh-keygen -R undercloud > /dev/null 2>&1
    sed -i "/undercloud\|$PUBLIC_IP/d" /etc/hosts
fi
