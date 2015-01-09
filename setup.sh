#! /bin/bash
# Generic install script for ArcGIS Server

# password to use
PASSWORD="esri"

# get the directory where this file is being located
LOCALDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# variable for the limits file
LIMITSFILE="/etc/security/limits.conf"

# write localhost address to hosts file so ArcGIS Server thinks the DNS is working
echo "127.0.0.1   $HOSTNAME" >> /etc/hosts


# add ags user
useradd ags

# set the user password
echo $PASSWORD | passwd --stdin ags

# set file handle limits
echo "ags soft nofile 65535" >> $LIMITSFILE
echo "ags hard nofile 65535" >> $LIMITSFILE
echo "ags soft nproc 25059" >> $LIMITSFILE
echo "ags hard nproc 25059" >> $LIMITSFILE

# move the source and license file into the temp directory
cp $LOCALDIR/ArcGIS_for_Server_Linux*.tar.gz /tmp
cp $LOCALDIR/arcgisServerLicense.ecp /tmp

# ensure enough permissions on the source
chmod 777 /tmp/ArcGIS_for_Server_Linux*.tar.gz

# extract the archive as the new user
su -c "tar -xf /tmp/ArcGIS_for_Server_Linux*.tar.gz -C /tmp/" ags

# run the install as the new user
su -c "/tmp/ArcGISServer/Setup -m silent -l yes -a /tmp/arcgisServerLicense.ecp" ags

# remove the temporary resources
rm -rf /tmp/ArcGISServer
rm -f /tmp/ArcGIS_for_Server_Linux*.tar.gz
rm -f /tmp/arcgisServerLicense.ecp

# copy the initilization script
cp $LOCALDIR/arcgisserver /etc/rc.d/init.d/

# ensure root is owner and has correct permissions
chown root /etc/rc.d/init.d/arcgisserver
chmod 550 /etc/rc.d/init.d/arcgisserver

# create links to files with correct run levels
chkconfig --add arcgisserver
chkconfig arcgisserver on
