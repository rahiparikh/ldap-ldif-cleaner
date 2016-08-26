## ldap-ldif-cleaner

Ever wanted to crack LDAP passwords but your passwords are in SSHA format? The script will extract the username & password hash pair after converting the SSHA format into a format that JTR (John The Ripper - www.openwall.com/john/) will be able to parse.
```
Usage: ldif_cleaner.sh [source] [destination]

[source]       Source file with LDAP export in LDIF format
[destination]  Output file that will have cleaned/extracted data from source file
```
## Contributors
Rahil Parikh

## License
Apache License, Version 2.0
