FROM debian

# Instalacion de todos los paquetes necesarios
RUN apt-get -y update
RUN apt-get -y install ntp cron iptables

# Reemplazar archivo de configuraciones de NTP
COPY ntp.conf /etc/ntp.conf

# Enviar scripts necesarios a la imagen
COPY backup.sh /bin/
COPY restore.sh /bin/
COPY firewall.sh /bin/
    
# Dar permiso de ejecucion a los scripts
RUN chmod +x /bin/backup.sh
RUN chmod +x /bin/restore.sh
RUN chmod +x /bin/firewall.sh

# Configurar el Crontab para automatizar el script de backup
RUN crontab -l | { cat; echo "30 7 * * * /bin/backup.sh"; }

CMD cron

