echo "Create tomcat user and group"
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat
echo "Update system"
sudo apt update
