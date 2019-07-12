#!/bin/bash
# Import email filters (previously exported)

# Load configuration
source ./CONFIG

# Restore Email Filters
for i in `cat $MAIL_LIST_FILE`; do
    /opt/zimbra/bin/zmprov ma  $i zimbraMailSieveScript "`cat /$BASEDIR/filter/$i.filter`";
    echo "Filter Restore for account ... $i";
done
