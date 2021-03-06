#!/bin/sh
fetch http://pfsense-cacheboy.googlecode.com/files/srg.tar.gz
tar -xvf srg.tar.gz -C /
echo "Working dir"
echo "/usr/local/www/srg_reports"
read path
if [ ! $path ]
then
path=/usr/local/www/srg_reports
fi
dir=`echo $path | sed 's+.*/++'`
sed -e 's+^output_dir.*+output_dir "'$path'"+' -e 's+^output_url .*+output_url "/'$dir'/"+' /usr/local/etc/srg/srg.conf > srg.conf.tmp
mv srg.conf.tmp /usr/local/etc/srg/srg.conf
if [ $path != /usr/local/www/$dir ]
then {
	rm -r /usr/local/www/$dir
	ln -s $path /usr/local/www/$dir
}
fi
hash -r
hostname=`hostname | sed 's/\...*//'`
echo "Your Reports can be veiwed at http://$hostname/$dir"
echo "Your SRG configurations is save in"
echo "--> /usr/local/etc/srg/srg.conf"
