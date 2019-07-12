#!/bin/bash
# Import email signatures (previously exported)

# Load configuration
source ./CONFIG

# Restore Email Signatures
for i in `cat $MAIL_LIST_FILE`; do
	/opt/zimbra/bin/zmprov ma $i zimbraSignatureName "`cat /$BASEDIR/signatures/$i.name`";
	/opt/zimbra/bin/zmprov ma $i zimbraPrefMailSignatureHTML "`cat /$BASEDIR/signatures/$i.signature`";
	/opt/zimbra/bin/zmprov ga $i zimbraSignatureId > /tmp/firmaid; sed -i -e "1d" /tmp/firmaid;
	firmaid=`sed 's/zimbraSignatureId: //g' /tmp/firmaid`;
	/opt/zimbra/bin/zmprov ma $i zimbraPrefDefaultSignatureId "$firmaid";
	/opt/zimbra/bin/zmprov ma $i zimbraPrefForwardReplySignatureId "$firmaid";
	rm -rf /tmp/firmaid;
	echo $i "done!";
done

