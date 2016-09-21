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

