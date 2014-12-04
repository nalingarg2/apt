#
# Cookbook Name:: ClusterB
# Recipe:: clusterB-setup
#
# Copyright (C) 2014 nalin garg
#
# All rights reserved - Do Not Redistribute
#

#http://thrift-tutorial.readthedocs.org/en/latest/installation.html

directory "/home/ubuntu/thrift" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"home/ubuntu/thrift') end
end

directory "/home/user" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"/home/user') end
end

directory "/home/user/Downloads" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"/home/user/Downloads') end
end

#-----------------------------------------------------------------------
file "/home/user/Downloads/ip_address0" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"/home/user/Downloads/ip_address0') end
end

bash "change ip address 0 list" do
  
  code <<-EOH
  cd /etc/

  echo "10.20.90.98 8987" >> /home/user/Downloads/ip_address0
  echo "54.78.43.32" >> /home/user/Downloads/ip_address0
  echo "localhost 8080" >> /home/user/Downloads/ip_address0

  EOH
 end


file "/home/user/Downloads/ip_address1" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"/home/user/Downloads') end
end

bash "change ip address 1 list" do
  
  code <<-EOH
  cd /etc/

  echo "10.20.90.98 8987" >> /home/user/Downloads/ip_address1
  echo "54.78.43.32" >> /home/user/Downloads/ip_address1
  echo "localhost 7910" >> /home/user/Downloads/ip_address1

  EOH
 end

#---------------------------------------------------------------------------
file "/home/user/list0.txt" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"/home/user/list0.txt') end
end

bash "change word 0 list" do
  
  code <<-EOH
  cd /etc/

  echo "Aarhus" >> /home/user/list0.txt
  echo "Aaron" >> /home/user/list0.txt
  echo "abandon" >> /home/user/list0.txt

  EOH
 end


file "/home/user/list1.txt" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"/home/user/list1.txt') end
end

bash "change word 1 list" do
  
  code <<-EOH
  cd /etc/

  echo "Ababa" >> /home/user/list1.txt
  echo "aback" >> /home/user/list1.txt
  echo "abaft" >> /home/user/list1.txt

  EOH
 end



#----------------------------------------------------------------------------


file "/home/ubuntu/build.xml" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"/home/ubuntu/build.xml') end
end


bash "build.xml" do
  
  code <<-EOH

  cat >> /home/ubuntu/build.xml << EOL
<?xml version="1.0" encoding="UTF-8"?>
<project name="SpellCheck" default="all" basedir=".">
    <property name="thrift.lib" value="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/libthrift-0.9.2.jar"/>
    <property name="lib.dir" value="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/lib"/>

<!-- main classes -->
    <property name="client-main" value="com.nalin.SpellClient"/>
    <property name="server-main" value="com.nalin.SpellServer"/>


    <!-- all -->
    <target name="all" depends="clean, compile, build"></target>
    <target name="clean">
        <delete dir="build"/>
    </target>
    <target name="compile">
        <mkdir dir="/home/ubuntu/project/Distributeds0s1/classes"/>
        <javac srcdir="/home/ubuntu/project/Distributeds0s1/" destdir="/home/ubuntu/project/Distributeds0s1/classes">
            <classpath>
                <pathelement location="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/libthrift-0.9.2.jar"/>
                <fileset dir="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/lib" includes="*.jar"/>
            </classpath>
        </javac>
    </target>
    <target name="build">
        <jar destfile="/home/ubuntu/project/Distributeds0s1/SpellCheck.jar" basedir="/home/ubuntu/project/Distributeds0s1/classes"/>
    </target>
<!-- client run -->
    <target name="client-run">
        <java fork="true" classname="com.nalin.SpellClient">
            <classpath>
                <path location="/home/ubuntu/project/Distributeds0s1/SpellCheck.jar"/>
                <pathelement location="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/lib"/>
                <fileset dir="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/lib" includes="*.jar"/>
            </classpath>
        </java>
    </target>

    <!-- server run -->
    <target name="server-run">
        <java fork="true" classname="com.nalin.SpellServer">
            <classpath>
                <path location="/home/ubuntu/project/Distributeds0s1/SpellCheck.jar"/>
                <pathelement location="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/libthrift-0.9.2.jar"/>
                <fileset dir="/home/ubuntu/thrift/thrift-0.9.2/lib/java/build/lib" includes="*.jar"/>
             </classpath>
        </java>
    </target>


</project>
EOL
  EOH

end


bash "Thrift set up" do
  
  code <<-EOH

  sudo su
  cd thrift
  apt-get update
  apt-get -y install libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev
  apt-get update
  sudo apt-add-repository ppa:webupd8team/java
  sudo apt-get update
  echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections 
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

  apt-get -y install oracle-java7-installer
  apt-get -y install git
  apt-get -y install make

  apt-get -y install ant
  wget http://www.dsgnwrld.com/am/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
  tar -zxvf apache-maven-3.2.3-bin.tar.gz
  export M2_HOME=/home/ubuntu/thrift/apache-maven-3.2.3   
  export M2=$M2_HOME/bin     
  
  export PATH=$M2:$PATH
  EOH
end

directory "/home/ubuntu/project" do
  mode 0755
  
  action :create
  not_if do :: File.exists?('"home/ubuntu/project') end
end
#git@github.com:nalingarg2/Distributed-Systems.git

git "/home/ubuntu/project" do
   repository "git://github.com/nalingarg2/Distributed-Systems.git"
   reference "sync"
   action :sync
#   user "user"
#   group "test"
end

bash "thrift setup " do
  
  code <<-EOH

  sudo su
  cd /home/ubuntu/thrift
  apt-get update
  sudo wget http://download.nextag.com/apache/thrift/0.9.2/thrift-0.9.2.tar.gz
  tar -zxvf thrift-0.9.2.tar.gz

  cd /home/ubuntu/thrift/thrift-0.9.2
  ./configure
  make
  make install
  

  EOH
end
#sudo /home/ubuntu/
#ant -f build.xml
#ant client-run
