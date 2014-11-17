oraclejava
========== 

Puppet module to install Oracle JDK 8, 7 or 6 by downloaded from the java oracle website. 

NOTE: JRE not yet supported. Install relies on wget being installed

Minimal Usage
=============

Install Java JDK7u67:

      class { 'oraclejava' : }
      
Install Java JDK7u67 via rpm:
   
      class { 'oraclejava::jdk7_rpm' : }        
      
Install Java JDK8u20:
   
      class { 'oraclejava::jdk8' : }

Install Java JDK8u20 via rpm:
   
      class { 'oraclejava::jdk8_rpm' : }       
     
 
 
Complex Usage
=============

Install Java JDK8u11

      class { 'oraclejava::jdk8' :
        java           => 'jdk-8u11',
        java_loc        => '/usr/java',
        java_dir        => 'jdk1.8.0_11',
        download_url    => 'http://download.oracle.com/otn-pub/java/jdk/8u11-b01/jdk-8u11-linux-x64.tar.gz'     
      } 
      
Install Java JDK8u11 via rpm via an http proxy

      class { 'oraclejava::jdk8_rpm' :
        java_loc        => '/usr/java',
        java_dir        => 'jdk1.8.0_11',
        wget_opt        => "-e use_proxy=yes -e http_proxy=10.78.129.66:3128",
        rpm_name        => 'jdk-8u11-linux-x64.rpm',
        download_url    => 'http://download.oracle.com/otn-pub/java/jdk/8u11-b01/jdk-8u11-linux-x64.rpm'     
      }
      
 
To determine the values for latest release of Java versions:

       http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
       
       http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
       
       
To determine the values for older releases of Java versions:

       http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html
       
       http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html
       
       http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html
