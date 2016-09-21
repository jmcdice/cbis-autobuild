#!/usr/bin/bash
#
# Install the CBIS undercloud
# Joey <joey.mcdonald@nokia.com>

source local-settings.sh

release=$1
build=$2
working_dir="cbis-$1-$2"

cd $working_dir

if [ -z $HWTYPE ]; then
   echo "Hardware type (HWTYPE) not defined in local-settings.sh"
   echo "Can not continue."
   exit 127
fi

echo "Preparing configuration for: $HWTYPE deployment."
UC="cbis-installer/templates/$HWTYPE/user_config.yaml"
cp $UC .
if [$? !=0 ]; then
   echo "Unable to access: $UC"
   echo "Can not continue."
   exit 127
fi

# These are values to be applied to the undercloud VM 
export UC_PUBLIC_IP='135.227.255.55' # Undercloud Public IP
export UC_PUBLIC_GW='135.227.248.1'  # Undercloud Default Route
export UC_NETMASK='255.255.248.0'    # Undercloud Netmask
export UC_DNS='135.1.1.111'	     # Undercloud DNS  Server
export UC_NTP='135.1.1.111'	     # Undercloud NTP Server

# These values are taken from the hypervisor compute where you'll run the undercloud
export HYPERVISOR_IP='135.227.255.54'
export HYPERVISOR_PUBLIC_INTERFACE='enp4s0f1'
export HYPERVISOR_PRIVATE_INTERFACE='enp4s0f0'

# Values for the overcloud, can be seperated by commas, for example:
# export OC_DNS='8.8.8.8, 8.8.4.4' 
export HWTYPE='hp-slg7_OVS'
export OC_NTP='135.1.1.111'
export OC_DNS='135.1.1.111'
export OC_TZ='UTC'

# Overcloud External Network Information
export OC_EXTERNAL_CIDR='135.227.248.0/21'
export OC_EXTERNAL_GW='135.227.248.1'
export OC_EXTERNAL_VLAN=''
export OC_EXTERNAL_IP_START='135.227.255.56'
export OC_EXTERNAL_IP_END='135.227.255.70'

# OverCloud Tenant Network Information
export OC_TENANT_NETWORK_CIDR='172.17.2.0/24'
export OC_TENANT_NETWORK_VLAN='40'

# OverCloud Storage Network Information
export OC_STORAGE_CIDR='172.17.3.0/24'
export OC_STORAGE_VLAN='41'

# OverCloud Storage Network Information
export OC_STORAGE_MGMT_CIDR='172.17.4.0/24'
export OC_STORAGE_MGMT_VLAN='42'

# OverCloud Storage Network Information
export OC_INTERNAL_API='172.17.1.0/24'
export OC_INTERNAL_API_VLAN='43'


