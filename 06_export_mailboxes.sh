#!/bin/bash
# Migrate zimbra data
# Migrate can by done for remote zimbra server via ssh connection

# Load configuration
source ./CONFIG


# Export Mailbox
echo "Exporting mailboxes list"
mblist=`cat $MAIL_LIST_FILE`
tot=`cat $MAIL_LIST_FILE | wc -l`

let i=0
for mb in $mblist; do
        let i=$i+1
	if [ -f /$BASEDIR/$mb.tgz -o -f /$BASEDIR/$mb.tgz.imported ]; then
        	echo "$i/$tot $mb (skipped)"
	else
        	echo "$i/$tot $mb"
        	$rcmd /opt/zimbra/bin/zmmailbox -z -t 0 -m $mb getRestURL "//?fmt=tgz" > /$BASEDIR/$mb.tgz.tmp && \
			mv /$BASEDIR/$mb.tgz.tmp /$BASEDIR/$mb.tgz
	fi
done

