#!/bin/bash
# Migrate zimbra data
# Migrate can by done for remote zimbra server via ssh connection

# Load configuration
source ./CONFIG

# Backup Users
echo "Exporting mailboxes list"
$rcmd /opt/zimbra/bin/zmprov -l gaa | sort > $MAIL_LIST_FILE
tot=`cat $MAIL_LIST_FILE | wc -l`

# Load mailbox list
mblist=`cat $MAIL_LIST_FILE`

# Backup admins
echo "Exporting admin users list"
$rcmd /opt/zimbra/bin/zmprov gaaa > $BASEDIR/admins.txt

# Backup userpass
echo "Exporting users passwords"
i=1
mkdir -p $BASEDIR/userpass
for mb in $mblist; do
	echo "Exporting $mb ($i/$tot)"
	let i=$i+1
	$rcmd /opt/zimbra/bin/zmprov -l ga $mb userPassword | grep userPassword: | \
		awk '{ print $2}' > $BASEDIR/userpass/$mb.shadow
done

# Backup userdata
echo "Exporting user data"
i=1
mkdir -p $BASEDIR/userdata
for mb in $mblist; do
	echo "Exporting $mb ($i/$tot)"
	let i=$i+1
	$rcmd /opt/zimbra/bin/zmprov ga $mb  | grep -i Name: > $BASEDIR/userdata/$mb.txt
done

cat <<__EOB__
Exported $tot mailboxes to $MAIL_LIST_FILE

You may need to edit the file and delete mailboxes you don't want to migrate, like spam, ham, virus, galsync, etc
__EOB__
