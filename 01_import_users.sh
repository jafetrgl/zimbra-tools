#!/bin/bash
# Import user data (previously exported)

# Load configuration
source ./CONFIG

# Restore Users
tot=`cat $MAIL_LIST_FILE | wc -l`

# Create emails accounts and set the old password
echo "** Importing users"
USERPASS="$BASEDIR/userpass"
USERDDATA="$BASEDIR/userdata"
USERS=$MAIL_LIST_FILE
i=1
for u in `cat $USERS`; do
	givenName=$(grep givenName: $USERDDATA/$u.txt | cut -d ":" -f2)
	displayName=$(grep displayName: $USERDDATA/$u.txt | cut -d ":" -f2)
	shadowpass=$(cat $USERPASS/$u.shadow)
	tmpPass="CHANGEme"
	echo " Creating $u ($i/$tot)"
	let i=$i+1
	/opt/zimbra/bin/zmprov ca $u CHANGEme cn "$givenName" displayName "$displayName" givenName "$givenName"
	/opt/zimbra/bin/zmprov ma $u userPassword "$shadowpass"
done

