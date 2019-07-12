#!/bin/bash
# Import user data (previously exported)

# Load configuration
source ./CONFIG

# Restore Users
tot=`cat $MAIL_LIST_FILE | wc -l`

# Recreate distribution lists
tot_lists=`cat $BASEDIR/distribution_lists.txt| wc -l`
i=1
for dl in `cat $BASEDIR/distribution_lists.txt`; do
	echo "Creating distribution list: $dl ($i/$tot_lists)"
	let i=$i+1
	echo /opt/zimbra/bin/zmprov cdl $dl
	k=1
	members=`cat $BASEDIR/distribution_list_members/$dl.txt | grep -v '#' | grep '@'`
	tot_members=`echo $members | wc -w`
        for m in $members; do
        	echo "  Adding member $m to $dl ($k/$tot_members)"
		let k=$k+1
        	#/opt/zimbra/bin/zmprov adlm $dl $m
        done
done

