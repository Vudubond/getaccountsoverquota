#!/bin/bash
# getaccountsoverquota.sh
# Get a list of accounts using more than 1G of disk space, and compare it to what they should be using according to their cPanel configured plan.
# Also alert with a list of accounts that aren't using one of our plan names.

for user in $(find /var/cpanel/users -type f | egrep -o '[a-zA-Z0-9]+$' | grep -v system); do 
		echo -n "$user: " ;
		echo -n `grep PLAN /var/cpanel/users/$user `;
		echo `du -shc /home/$user`;
done