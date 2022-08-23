echo "Create tomcat user and group"
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat
echo "Update system"
sudo apt update
echo "Install java"
sudo apt-get install openjdk-11-jdk -y
echo "check java version"
java -version
echo "Download tar file for tomcat"
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz
echo "unzip tar file"
sudo tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1
echo "Change ownership"
sudo chown -R tomcat:tomcat /opt/tomcat/
echo "Change file permission"
sudo chmod -R u+x /opt/tomcat/bin
echo "Add following lines"
printf "\n[Unit]\nDescription=Apache Tomcat Web Application Container\nAfter=network.target\n[Service]\nType=forking\nEnvironment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64/\nEnvironment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid\nEnvironment=CATALINA_HOME=/opt/tomcat\nEnvironment=CATALINA_BASE=/opt/tomcat\nEnvironment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'\nEnvironment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'\nExecStart=\nExecStart=/opt/tomcat/bin/startup.sh\nExecStop=/opt/tomcat/bin/shutdown.sh\nUser=tomcat\nGroup=tomcat\nUMask=0007\nRestartSec=10\nRestart=always\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/tomcat.service
echo "Start tomcat"
sudo systemctl start tomcat.service
echo "Check status of tomcat"
systemctl status tomcat.service