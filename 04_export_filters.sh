#!/bin/bash
# Migrate zimbra data
# Migrate can by done for remote zimbra server via ssh connection

## --------- [Config Parameters] ---------

# Load configuration
source ./CONFIG

# Backup Users
tot=`echo $MAIL_LIST_FILE | wc -w`

# Backup filters
mkdir /$BASEDIR/filter
i=1
for mb in $MAIL_LIST_FILE ; do
	echo $i/$tot $mb
	let i=$i+1
    $rcmd /opt/zimbra/bin/zmprov ga $mb zimbraMailSieveScript > /tmp/filter
    sed -i -e "1d" /tmp/filter
    sed 's/zimbraMailSieveScript: //g' /tmp/filter  > /$BASEDIR/filter/$mb.filter
    rm -f /tmp/filter
    echo "Filter downloaded for .... $mb"
done

