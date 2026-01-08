#!/bin/sh

TEMPDIR="/tmp/webfiles"
os=$(awk -F= '/^ID=/ {print $2}' /etc/os-release)
if [ "$os" = "ubuntu" ]
then
	PACKAGE="apache2 wget unzip"
	SVC="apache2"
	URL="https://www.tooplate.com/zip-templates/2153_fireworks_composer.zip"
	ART_NAME="2153_fireworks_composer"
	
	echo "Installing apache2 wget unzip"
	echo "#####################################"
	sudo apt update &> /deb/null
	sudo apt install $PACKAGE -y > /dev/null
	echo "#####################################"

	#Downloading web files
	echo "Downloading Web files"
	echo "#####################################"
	mkdir $TEMPDIR
	cd $TEMPDIR
	wget $URL
	unzip $ART_NAME
	sudo cp -r $ART_NAME/* /var/www/html
	echo "#####################################"
	echo " "

	#Clean UP
	echo "Removing temporary files"
	echo "######################################"
	rm -rf $TEMPDIR
	echo " "

	#Starting the service
	echo "Starting Apache2 service"
	echo "######################################"
	sudo systemctl start $SVC

	sudo systemctl status $SVC

else
	PACKAGE="httpd wget unzip"
        SVC="httpd"
	URL="https://www.tooplate.com/zip-templates/2148_bistro_elegance.zip"
        ART_NAME="2148_bistro_elegance"

        echo "Installing httpd wget unzip"
        echo "#####################################"
        sudo yum install $PACKAGE -y > /dev/null
        echo "#####################################"

        #Downloading web files
        echo "Downloading Web files"
        echo "#####################################"
        mkdir $TEMPDIR
        cd $TEMPDIR
        wget $URL
        unzip $ART_NAME
        sudo cp -r $ART_NAME/* /var/www/html
        echo "#####################################"
        echo " "

        #Clean UP
        echo "Removing temporary files"
        echo "######################################"
        rm -rf $TEMPDIR
        echo " "

        #Starting the service
        echo "Starting Apache2 service"
        echo "######################################"
        sudo systemctl start $SVC

        sudo systemctl status $SVC
fi




