#!/usr/bin/bash
#
# The poor man's YML parser.

source ../local-settings.sh
#perl -p -i -e 's/<%= ENV\[\"(.*?)\"\] %>/defined $ENV{$1} ? $ENV{$1} : $&/eg' < user_config_template.yaml > user_config.yaml
perl -p -i -e 's/<%= ENV\[\"(.*?)\"\] %>/defined $ENV{$1} ? $ENV{$1} : $&/eg' < ../test.yaml > ../user_config.yaml
