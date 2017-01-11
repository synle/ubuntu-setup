#https://www.tutorialspoint.com/hadoop/hadoop_enviornment_setup.htm

#users
useradd hadoop
passwd hadoop

ssh-keygen -t rsa 
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys 
chmod 0600 ~/.ssh/authorized_keys 

#java
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

#hadoop
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_PREFIX=/usr/local/hadoop
