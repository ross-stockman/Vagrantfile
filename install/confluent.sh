artifact=confluent-oss-4.1.1-2.11.tar.gz
unzipped=confluent-4.1.1

tar -zxvf /vagrant/downloads/$artifact
mv $unzipped confluent
sudo mv confluent /usr/lib/
echo 'export CONFLUENT_HOME=/usr/lib/confluent' | sudo tee -a /etc/profile
echo 'export PATH=$PATH:$CONFLUENT_HOME/bin' | sudo tee -a /etc/profile
source /etc/profile
