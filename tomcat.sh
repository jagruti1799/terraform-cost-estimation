echo "Create tomcat user and group"
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat
echo "Update system"
sudo apt update
echo "Install java"
sudo apt-get install openjdk-11-jdk -y
echo "check java version"
java -version
