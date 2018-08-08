#!/bin/sh

WAIT="1.5"
C_YELLOW="\033[33m"
C_RESET="\033[0m"
C_BOLD="\033[1m"
C_GREEN="\033[32m"
C_RED="\033[31m"

trap '{ echo "$C_RESET\nKeyboard Interrupt detected."; sleep 0.5; exit 1; }' INT

[ $# -ne 4 ] && { echo "Usage: $0 <SSH_port> <root_pass> <user_pass> <user_name>"; exit 1; }

PORT=$1 # argv[1]
PASS_ROOT=$2 # argv[2]
PASS_USER=$3 # argv[3]
USER=$4 # argv[4]

# Display stuff
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT
echo -n $C_RESET; echo -n $C_GREEN; echo "Starting script -- Running on \"$(uname -n)\"..."
echo -n $C_RESET; sleep $WAIT
echo -n $C_BOLD; uname -a
echo -n $C_RESET; sleep $WAIT
echo -n $C_GREEN; echo "Disk usage..."
echo -n $C_RESET; sleep $WAIT
echo -n $C_BOLD; df -h / | sed 1d | awk '{printf "size: %s; used: %s (%s); available: %s\n", $2, $3, $5, $4}'
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Update sources, install & upgrade packages:
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
sudo apt-get -y install sudo
sudo apt-get -y install vim
sudo apt-get -y install less
sudo apt-get -y install ascii
sudo apt-get -y install bc
sudo apt-get -y install colordiff
sudo apt-get -y install cron
sudo apt-get -y install screen
sudo apt-get -y install curl wget
sudo apt-get -y install git
sudo apt-get -y install iptables
# sudo apt-get -y install fail2ban ufw
sudo apt-get -y install htop iftop tree psmisc
sudo apt-get -y install whois dnsutils tcpdump
sudo apt-get -y install tor
sudo apt-get -y install python-pip python3-pip python-dev python3-dev
sudo apt-get -y install build-essential gcc g++ make
sudo apt-get -y install source-highlight
sudo apt-get -y install zip unzip
sudo apt-get -y install mailutils
sudo apt-get -y autoremove
sudo apt-get -y autoclean
curl -sL "https://deb.nodesource.com/setup_10.x" | sudo -E bash -
sudo apt-get -y install nodejs
echo -n $C_GREEN; echo "Done updating sources, installing & upgrading given packages."
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT


# Set blank motd:
cat /dev/null > /etc/motd
echo -n $C_GREEN; echo "File /etc/motd has been wiped out."
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Change DNS servers to https://1.1.1.1/
echo "domain openstacklocal\nsearch openstacklocal\nnameserver 1.1.1.1\nnameserver 1.0.0.1\nnameserver 8.8.8.8\nnameserver 8.8.4.4" > /etc/resolv.conf 2>/dev/null
sudo chattr +i /etc/resolv.conf
/etc/init.d/networking restart
if nslookup google.com | grep '1.1.1.1' 1>/dev/null;
	then echo -n $C_GREEN; echo "Changed DNS servers to [1.1.1.1, 1.0.0.1].";
	else echo -n $C_RED; echo "Failed to change DNS servers...";
fi
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Change SSH port & `PrintLastLog` value
sed -i "s/#Port 22/Port $PORT/g" /etc/ssh/sshd_config
sed -i "s/#PrintLastLog yes/PrintLastLog no/g" /etc/ssh/sshd_config
echo -n $C_GREEN; echo "Changed \`Port\` value to $PORT & \`PrintLastLog\` value to \`no\`."
echo -n $C_BOLD; echo "Restarting sshd service..."
echo -n $C_RESET; /etc/init.d/ssh restart
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Change root default password
echo "root:$PASS_ROOT" | sudo chpasswd
echo -n $C_GREEN; echo "Changed default root password"
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Set fail2ban up
#cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local	
#cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
#echo -n $C_GREEN; echo "Copied fail2ban .conf files to .local rules."
#echo -n $C_RESET; sudo service fail2ban stop
#echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Set firewall (ufw) up
#sudo systemctl enable ufw
#sudo systemctl restart ufw
#echo -n $C_GREEN
#echo -n "[+] "; sudo ufw logging on
#echo -n "[+] "; sudo ufw default deny incoming
#echo -n "[+] "; sudo ufw default allow outgoing
#echo -n "[+] "; sudo ufw allow $PORT/tcp
#echo "[>] Successfully set firewall rules, details:"
#echo -n $C_RESET; yes | sudo ufw enable
#echo -n $C_RESET; echo -n $C_BOLD; sudo ufw status verbose; sleep $WAIT
#echo -n $C_RESET; sudo service fail2ban start
#echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Add non-root user
sudo adduser $USER --gecos ",,," --disabled-password --force-badname
echo -n $C_GREEN; echo "Created new user $USER."
echo -n $C_RESET; echo "$USER:$PASS_USER" | sudo chpasswd
echo -n $C_GREEN; echo "Set $USER's password."
echo -n $C_RESET; echo -n $C_BOLD; sudo adduser $USER sudo
echo -n $C_RESET; echo -n $C_GREEN; echo "Added $USER to sudoers."
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
echo -n $C_GREEN; echo "Changed \`PermitRootLogin\` value to \`no\`."
echo -n $C_BOLD; echo "Restarting sshd service..."
echo -n $C_RESET; /etc/init.d/ssh restart
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Add dotfiles to non-root user's home
curl "https://raw.githubusercontent.com/nyo/dotfiles/master/Debian/.vimrc" > "/home/$USER/.vimrc"
mkdir -p "/home/$USER/.vim"
mkdir -p "/home/$USER/.vim/autoload"
curl "https://raw.githubusercontent.com/drewtempelmeyer/palenight.vim/master/autoload/palenight.vim" > "/home/$USER/.vim/autoload/palenight.vim"
mkdir -p "/home/$USER/.vim/colors"
curl "https://raw.githubusercontent.com/drewtempelmeyer/palenight.vim/master/colors/palenight.vim" > "/home/$USER/.vim/colors/palenight.vim"
mkdir -p "/home/$USER/.vim/bundle"
git clone "https://github.com/pangloss/vim-javascript.git" "/home/$USER/.vim/bundle/vim-javascript"
echo -n $C_GREEN; echo "Successfully imported vim .files to /home/$USER/"
curl "https://raw.githubusercontent.com/nyo/dotfiles/master/Debian/.bashrc" > "/home/$USER/.bashrc"
curl "https://raw.githubusercontent.com/nyo/dotfiles/master/Debian/.bash_profile" > "/home/$USER/.bash_profile"
curl "https://raw.githubusercontent.com/nyo/dotfiles/master/Debian/.gitconfig" > "/home/$USER/.gitconfig"
curl "https://raw.githubusercontent.com/nyo/dotfiles/master/Debian/.nanorc" > "/home/$USER/.nanorc"
curl "https://raw.githubusercontent.com/nyo/dotfiles/master/Debian/.banner" > "/home/$USER/.banner"
echo -n $C_GREEN; echo "Successfully imported bash/git/nano .files to /home/$USER/"
echo -n $C_RESET; curl "https://raw.githubusercontent.com/nyo/dotfiles/master/Debian/update.sh" > /root/update.sh
(crontab -l ; echo "0 4 * * 1 /bin/sh /root/update.sh >/dev/null 2>&1") | crontab -
echo -n $C_GREEN; echo "Auto-update script will now be executed once a week as su."
echo -n $C_RESET; echo "+ --------- +"; sleep $WAIT

# Reboot
echo -n $C_YELLOW; echo "Auto-destructing some files..."
rm -f /root/.bash_history /root/.wget-hsts $0
echo -n $C_YELLOW; echo "Done. Restarting, cya!"; sleep $WAIT
reboot
