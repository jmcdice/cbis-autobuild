#!/usr/bin/bash
#
# Install the CBIS undercloud
# Joey <joey.mcdonald@nokia.com>

source ../local-settings.sh

#release=$1
#build=$2
#working_dir="cbis-$1-$2"

if [ -z $HWTYPE ]; then
   echo "Hardware type (HWTYPE) not defined in local-settings.sh"
   echo "Can not continue."
   exit 127
fi

echo "Preparing configuration for: $HWTYPE deployment."
echo "Writing out overcloud config file: user_config.yaml"
perl -p -i -e 's/<%= ENV\[\"(.*?)\"\] %>/defined $ENV{$1} ? $ENV{$1} : $&/eg' < user_config_template.yaml > ../user_config.yaml

