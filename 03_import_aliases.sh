#!/bin/bash
# Import user data (previously exported)

# Load configuration
source ./CONFIG

# Restore Users
tot=`cat $MAIL_LIST_FILE | wc -l`

# Restore alias accounts
i=1
for u in `cat $MAIL_LIST_FILE`; do
	echo "Importing aliases for $u ($i/$tot)"
	let i=$i+1
	if [ -f "$BASEDIR/alias/$i.txt" ]; then
        	for a in `grep '@' $BASEDIR/alias/$u.txt`; do
        		#/opt/zimbra/bin/zmprov aaa $u $a
        		echo "$i HAS ALIAS $j --- Restored"
        	done
        fi
done

