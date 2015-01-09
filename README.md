# ArcGIS Server CentOS Install

------

This repository is little more than the script I use and the modified argisserver file used to silently install ArcGIS for Server 10.3 on a clean Minimal Desktop install of CentOS 6.6. If you want to reproduce the process, first create a CentOS 6.6 environment to work in. Next, get the install files and a license file from Esri. Rename the license file and update the setup script with the name of your license file. Finally, from the terminal as root, run the install.

## Create a CentOS Environment

There are a multitude of ways to go about this. In my case, I am using a VMWare virtual machine with a Minimal Desktop install. Rather than go into the details, there is an [excellent blog posting on how to do a CentOS 6.6 Netinstall](http://www.if-not-true-then-false.com/2011/centos-6-netinstall-network-installation/) I used as a guide. The only difference is at step 3.19, choose *Minimal Desktop*.

Also, once installed, there are two additional software packages I find handy, GEdit and Firewall. Once finished with the installation, go to System > Administration > Add/Remove Software. In here, search for *GEdit* and check the box next to *Text editor for the GNOME desktop*. Next, search for *firewall* and check the box next to *A graphical interface for basic firewall setup*.

## Collect and Setup Resources

Not included in the repository, but very much required are the install files and the license file. You will need to procure both of these on your own. Place both of them in the same directory on the CentOS system where you have saved the files from this repository. In my case, my license file is an .ecp file I simply renamed to arcgisServerLicense.ecp. If you license file is a different type or you want to give it a different name, just change this variable toward the top of the script on line eight.

## Run the Install

From here, you are ready to install. The script must be run as root, but this is easy enough to do from the command line. Do this by opening up terminal from Applications > System Tools > Terminal. In terminal switch to root using the command:

    $ su
    
It will prompt you to enter the root password. Next, switch to the directory where you saved the script using the command:

    $ cd /path/to/the/directory
   
Now, go ahead and execute the install script by entering the command:

    $ ./setup.sh
    
This will create a new user named *ags* with the password *esri*, configure a input/output requirement, install ArcGIS Server, license ArcGIS Server and set up ArcGIS Server to start every time the system starts.

## Open Required Ports

What the script does not do however, is open up the necessary ports for ArcGIS Server. This can be accomplished by going to System > Administration > Firewall. Once in firewall, set up your ports under *Other*. If you want just a standalone server for testing, just open port 6080. If you also want secured services, also open port 6443. Finally, if you want the server to participate in a cluster, open at least ports 4000-4004. Since there are a number of ports used in here, I opened 4000-4015, just to avoid any issues.

If you did everything correctly, you now have a running system with ArcGIS Server. It may be a good idea to change the password for the ags user, but besides, this, everything should be functioning. Best of luck!