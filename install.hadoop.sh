#https://www.tutorialspoint.com/hadoop/hadoop_enviornment_setup.htm

wget http://apache.claz.org/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz;
tar xzf hadoop-2.7.3.tar.gz ;
rm hadoop-2.7.3.tar.gz ;
mv hadoop-2.7.3/ hadoop;
mv hadoop/ /usr/local/;


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


#test run
mkdir /tmp/input;
cp $HADOOP_HOME/*.txt /tmp/input;
hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /tmp/input.txt /tmp/output;
cat /tmp/output/*
