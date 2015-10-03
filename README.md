# 24dev-demo
Customizable Addon prototyping scripts for the OSGeo Live DVD.

This demo is intended to provide users with an easy way to try and develop 
applications.  The "24dev" name is a play on words for: "Two For DEVelopment",
via the Open Source Community (OSC) and you the Open Source Developer (OSD).  
Both users can leverage the following features:
* Users can install 24dev applications to a live OSGeo DVD via running one script.
* Users can rename the base directory and re-run the install script to update profiles.   
* The install script creates a backup tar file.
* OSD user scripts can display custom license/release files for each application.  
* OSD users are encouraged to fork new release via github renamed as: 24dev-<myApp>. 
* OSD users are encouraged to append their details to the existing license/release files. 

To install 24dev-demo to an OSGeo system:
* Download the latest version of the 24dev-demo tar file and install on a USB flash drive.
* Boot your computer with the OSGeo Live DVD.
* Copy the tar file to the OSGeo Desktop.
* Right click on the tar file and select "Extact Here".
* Navigate to the extracted folder, open a terminal window and run the following command:
    ./apps/install2Osgeo/bin/install2Osgeo.sh
* The above command will create databases, install and test the required programs.
* The program documentation is located online at:  https://github.com/pmcgover/24dev-demo  

