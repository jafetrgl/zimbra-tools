# Zimbra migration scripts

## Initialization

This script are designed to be run in the destination zimbra server. They require ssh passwordless connection to the source zimbra server

  * Edit CONFIG file
    * Set temp dir for data migration. Make sure you have enough storage for mailbox migration!
    * Set source zimbra server
  * Create temp dir

## Migration

  * Export/import users

```
sh 01_export_users.sh
sh 01_import_users.sh
```
  * Export/import distribution lists

``` 
sh 02_export_distribution_lists.sh
sh 02_import_distribution_lists.sh
```

  * Export/import aliases

```
sh 03_export_aliases.sh
sh 03_import_aliases.sh
```

  * Export/import filters

```
sh 04_export_filters.sh
sh 04_import_filters.sh
```

  * Export/import signatures

```
sh 05_export_signatures.sh
sh 05_import_signatures.sh
```
  
  * Export/import mailboxes

```
sh 06_export_mailboxes.sh
sh 06_import_mailboxes.sh
```

