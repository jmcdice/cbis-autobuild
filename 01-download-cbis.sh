#!/usr/bin/bash
#
# Download CBIS
# Joey <joey.mcdonald@nokia.com>

debug=''

release=$1
build=$2

function download_cbis() {

   mkdir cbis-$release-$build
   working="cbis-$release-$build"

   echo "Downloading CBIS: This takes forever..."
   if [ -z "$debug" ]; then
      wget http://cbis-build.cloud-band.com/cbis_local_repo/$release/lastSuccessfulBuild/cbis-installer.tar.gz -O $working/cbis-installer.tar.gz
   else
      cp /root/cbis-installer.tar.gz $working/
   fi
}

if [ -z "$build" ] || [ -z "$release" ]; then
   echo "Usage: $0 <release> <build number>"
   exit 255
fi

download_cbis
bash 02-install-cbis.sh cbis-$release-$build
