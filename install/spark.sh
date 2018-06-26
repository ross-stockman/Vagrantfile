spark=spark-2.1.0-bin-hadoop2.7

tar -xzvf /vagrant/downloads/$spark.tgz
mv $spark spark
sudo mv spark /usr/lib/
echo 'export SPARK_HOME=/usr/lib/spark' | sudo tee -a /etc/profile
echo 'export PATH=$PATH:$SPARK_HOME/bin' | sudo tee -a /etc/profile
source /etc/profile

