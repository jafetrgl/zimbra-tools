#!/bin/bash
# Migrate zimbra data
# Migrate can by done for remote zimbra server via ssh connection

# Load configuration
source ./CONFIG

# Load mailbox list
mblist=`cat $MAIL_LIST_FILE`
tot=`cat $MAIL_LIST_FILE | wc -l`

# Backup distribution lists and members
echo "Exporting distribution lists and members"
$rcmd /opt/zimbra/bin/zmprov gadl > $BASEDIR/distribution_lists.txt
tot_dl=`cat $BASEDIR/distribution_lists.txt | wc -l`
i=1
mkdir -p $BASEDIR/distribution_list_members
for dl in `cat $BASEDIR/distribution_lists.txt`; do 
	echo "Exporting $dl ($i/$tot_dl)"
	let i=$i+1
	$rcmd /opt/zimbra/bin/zmprov gdlm $dl > $BASEDIR/distribution_list_members/$dl.txt; 
done

cat <<__EOB__
Exported $tot mailboxes to $MAIL_LIST_FILE

You may need to edit the file and delete mailboxes you don't want to migrate, like spam, ham, virus, galsync, etc
__EOB__
