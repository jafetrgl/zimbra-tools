#!/bin/bash
# Migrate zimbra data
# Migrate can by done for remote zimbra server via ssh connection

# Load configuration
source ./CONFIG

# Backup Users
tot=`echo $MAIL_LIST_FILE | wc -w`

# Backup signature
mkdir /$BASEDIR/signature
i=1
for mb in $MAIL_LIST_FILE ; do
	echo $i/$tot $mb
	let i=$i+1
	$rcmd /opt/zimbra/bin/zmprov ga $mb zimbraPrefMailSignatureHTML > /tmp/signature;
	sed -i -e "1d" /tmp/signature ;
	sed 's/zimbraPrefMailSignatureHTML: //g' /tmp/signature > /$BASEDIR/signatures/$mb.signature ;
	rm -rf /tmp/signature;
	$rcmd /opt/zimbra/bin/zmprov ga $mb zimbraSignatureName > /tmp/name ;
	sed -i -e "1d" /tmp/name ;
	sed 's/zimbraSignatureName: //g' /tmp/name > /$BASEDIR/signatures/$mb.name ;
	rm -rf /tmp/name ;
done

