#!/usr/bin/bash
#
# Script to check and see if we should do a build.
# Joey <joey.mcdonald@nokia.com>

# This is the major release you wish to build.
cur='17.02'

function check_local_settings() {

   # Make sure they modified the local.settings file

   md5='79407531dfea9d80f87fd0b132fa03f5'
   mod=$(md5sum local-settings.sh |awk '{print $1}')

   if [ $md5 == $mod ]; then
      echo "Please update local-settings.sh before trying to proceed."
      exit 127
   fi
}

function get_remote_build_number() {

   if [ ! -d db ]; then
      # First run?
      mkdir db
   else
      rm db/remote_build_number.txt
   fi

   wget -q http://cbis-build.cloud-band.com/cbis_local_repo/$cur/lastSuccessfull -O db/remote_build_number.txt 
   remote_current=$(cat db/remote_build_number.txt)
   echo $remote_current
}

function get_local_build_number() {

   if [ ! -f db/lastSuccessfull ]; then
      echo 0
   else 
      local_build=$(cat db/lastSuccessfull)
      echo $local_build
   fi
}

check_local_settings

remote_build=$(get_remote_build_number)
local_build=$(get_local_build_number)

if [ $remote_build -gt $local_build ]; then
   echo "A newer version ($remote_build) of cbis is available." 
   bash 01-download-cbis.sh $cur $remote_build
else
   echo "We have the latest build."
fi

