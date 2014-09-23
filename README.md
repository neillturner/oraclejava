oraclejava
========== 

Puppet module to install Oracle JDK 8, 7 or 6 by downloaded from the java oracle website. 

NOTE: JRE not yet supported and it relies on wget being installed

Minimal Usage
=============

      Install Java JDK7u67:

      class { 'oraclejava' : }
      
      install Java JDK8u20:
   
      class { 'oraclejava::jdk8' : }
       
     
 
 
Complex Usage
=============

      class { 'oraclejava::jdk8' :
        java           => 'jdk-8u11',
        java_loc        => '/usr/java',
        java_dir        => 'jdk1.8.0_11',
        download_url    => 'http://download.oracle.com/otn-pub/java/jdk/8u11-b01/jdk-8u11-linux-x64.tar.gz'     
      }  
 
  This install Java JDK8u11
  
  To determine the values for this go to 
       http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html
       http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html
       http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html
