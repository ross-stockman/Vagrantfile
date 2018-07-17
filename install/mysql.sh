sudo apt-get update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server

echo "Execute the following command to secure mysql:"
echo "sudo mysql_secure_installation"
echo "be sure to remove ananymous users and disallow remote login and reload privileges"
