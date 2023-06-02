# Politicas por defecto
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Permitir conexiones establecidas y relacionadas
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Permitir entrada por el puerto 22 para conexion SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Evita el acceso a ICMP (ping)
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Limita las conexiones entrantes para evitar ataques de fuerza bruta
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m limit --limit 3/minute --limit-burst 3 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j DROP
