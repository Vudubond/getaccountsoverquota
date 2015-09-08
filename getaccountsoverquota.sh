#!/bin/bash
# getaccountsoverquota.sh
# Get a list of accounts using more than 1G of disk space, and compare it to what they should be using according to their cPanel configured plan.
# Also alert with a list of accounts that aren't using one of our plan names.
tmpfile="/tmp/accountsover1g.txt"

du -shc /home/* |grep G >> $tmpfile

echo "Garden Patch: 2G ||    Farmstead: 5G ||    Rancher: 20GB"

for user in $(egrep -o '[a-zA-Z0-9]+$' $tmpfile | grep -v total |grep -v log |grep -v VIRTFS|cut -d'/' -f3); do
                echo -n -e "$user: \t" ;
                echo -n `grep PLAN /var/cpanel/users/$user`;
                echo -n -e '\t\t';
                echo `grep $user $tmpfile`;
done

/bin/rm $tmpfile