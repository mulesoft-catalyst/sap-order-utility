# sap-order-utility

  -  This is SAP Order Utility API used to listen to IDOCs from SAP
  -  Receives Order 05 IDOCs using document listener component for order create/update/delete.
  -  The standard order header and items fields in the IDOCs are converted into JSON Format.Examples of IDOC xml and JSON format can be found under src/main/resources/examples folder.
  -  This utility also demostrates the usage of filters in dataweave to filter out the required segments from the IDOC Order 05.

     
   
# Prerequisite Setup

- To run this project SAP Connector requires the below three libararies
	- com.sap.conn.jco.sapjco3
	- com.sap.conn.idoc.sapidoc3
	- libsapjco3 - type=jnilib in case of MacOS and type=dll in case of Windows
	- These connector dependencies can be downloaded from SAP Support portal
	
SAP system API requires the following libraries

	1.Two multi-platform Java libraries:
	
	sapjco3.jar
	sapidoc3.jar

	2.One of the JCo platform-specific native libraries:
	
	sapjco3.dll (Windows)
	libsapjco3.jnilib (Mac OS X)
	libsapjco3.so (Linux)

################Maven commands to install the jars################################################


############Maven commands to install the multi-platform Java libraries ##########################


mvn install:install-file -Dfile=sapjco3.jar -DgroupId=com.sap.conn.jco -DartifactId=com.sap.conn.jco.sapjco3 -Dversion=3.x.x -Dpackaging=jar


mvn install:install-file -Dfile=sapidoc3.jar -DgroupId=com.sap.conn.idoc -DartifactId=com.sap.conn.idoc.sapidoc3 -Dversion=3.x.x -Dpackaging=jar


###########################MacOS##################################################################

mvn install:install-file -Dfile=darwinintel64/libsapjco3.jnilib -DgroupId=com.sap.conn.jco -DartifactId=libsapjco3 -Dversion=3.x.x -Dclassifier=external-library -Dpackaging=jnilib


############################Linux#################################################################

mvn install:install-file -Dfile=linuxx86_64/libsapjco3.so -DgroupId=com.sap.conn.jco -DartifactId=libsapjco3 -Dversion=3.x.x -Dclassifier=external-library -Dpackaging=so

#############################Windows##############################################################

mvn install:install-file -Dfile=NTintel/sapjco3.dll -DgroupId=com.sap.conn.jco -DartifactId=libsapjco3 -Dversion=3.x.x -Dclassifier=external-library -Dpackaging=dll

##################################################################################################

## Installation instructions for Studio


- To run the project, right-click the project and select Run As --> Mule Application

	Add below VM Arguments,

	-M-XX:-UseBiasedLocking -M-Dfile.encoding=UTF-8 -M-XX:+UseG1GC -M-XX:+UseStringDeduplication -M-Dmule.verbose.exceptions=true -M-Druntime.key=1234567890123456 -M-Denv=local

	Make sure the config-local.yaml properties are updated with respective values.

  
