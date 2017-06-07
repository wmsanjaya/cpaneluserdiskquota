#!/bin/ ash
#Check cPanel Accounts
re='^[0-9]+$'
es=''
echo "Scan cPanel Accounts"
cd /var/cpanel/users
for user in *
do
  echo $user
  echo "---------------------------"
  total_size=0
  for disksize in `quota -u $user | awk '{print $2}'`
  do
     if [[ $disksize =~ $re ]]
     then
	let total_size+=$disksize
     fi
   done
   total_size_gb=0
   let total_size_gb+=$total_size/1048576
    if [[ $total_size_gb -gt 20 ]]
    then
       echo 'user exceed the 20GB'| mail -s "Disk Quota Warning!" myemail@wmsanjaya.com
    fi
done
