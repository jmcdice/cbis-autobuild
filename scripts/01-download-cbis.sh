#!/usr/bin/bash
#
# Download CBIS
# Joey <joey.mcdonald@nokia.com>

# This will allow you to avoid downloading the latest cbis version
# While developing. Run this in your shell
# export CBIS_DEBUG='true'

release=$1
build=$2

function download_cbis() {

   mkdir cbis-$release-$build
   working="cbis-$release-$build"

   echo "Downloading CBIS: This takes forever..."
   if [ "$CBIS_DEBUG" == 'true' ]; then
      cp /root/cbis-installer.tar.gz $working/
   else
      wget http://cbis-build.cloud-band.com/cbis_local_repo/$release/lastSuccessfulBuild/cbis-installer.tar.gz -O ../$working/cbis-installer.tar.gz
   fi
}

if [ -z "$build" ] || [ -z "$release" ]; then
   echo "Usage: $0 <release> <build number>"
   exit 255
fi

download_cbis
bash 02-install-undercloud.sh $release $build
