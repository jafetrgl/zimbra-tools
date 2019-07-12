#!/bin/bash
# Import user mailboxes (previously exported)

# Load configuration
source ./CONFIG

# Import Mailbox
files=`ls $BASEDIR/*.tgz`
tot=`echo $files | wc -w`
i=1
for f in $files ; do 
  mbox=`basename $f | sed 's/\.tgz$//'`
  echo "$i/$tot Import $f -> $mbox"
  let i=$i+1
  /opt/zimbra/bin/zmmailbox -z -m $mbox postRestURL "/?fmt=tgz&resolve=skip" $f && mv $f $f.imported
  echo "DONE"
done
