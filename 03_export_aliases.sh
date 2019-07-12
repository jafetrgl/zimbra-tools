#!/bin/bash
# Migrate zimbra data
# Migrate can by done for remote zimbra server via ssh connection

# Load configuration
source ./CONFIG

# Export aliases
mkdir -p /$BASEDIR/alias
for i in `cat $MAIL_LIST_FILE`; do zmprov ga $i | grep zimbraMailAlias |awk '{print $2}' > /$BASEDIR/alias/$i.txt ;echo $i ;done
