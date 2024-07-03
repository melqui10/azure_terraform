#!/bin/bash
# Instalar Apache
apt-get update
apt-get install -y apache2

# Obter o nome da máquina e o IP público
vm_name=$(hostname)
public_ip=$(curl -s ifconfig.me)

# Criar o arquivo index.html
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Informações da VM</title>
</head>
<body>
  <h1>Nome da VM: $vm_name</h1>
  <h2>Endereço IP Publico: $public_ip</h2>
</body>
</html>
EOF

# Iniciar o Apache
systemctl restart apache2
