
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
