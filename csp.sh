#!/bin/bash
# Bash script to install latest version of ffmpeg and its dependencies on Ubuntu 12.04 or 14.04
txtrst=$(tput sgr0) # Text reset
txtred=$(tput setab 1) # Red Background
textpurple=$(tput setab 5) #Purple Background
txtblue=$(tput setab 4) #Blue Background
txtgreen=$(tput bold ; tput setaf 2) # GreenBold
txtyellow=$(tput bold ; tput setaf 3) # YellowBold
arch=$(getconf LONG_BIT)
iplocal=$(ifconfig  | grep 'inet addr' | awk '{print $2}' | cut -d ':' -f2 |grep -v 127)
echo "${txtblue}Preparing System, please wait ........................ ${txtrst}"
echo "${txtgreen}....................................................................${txtrst}"
#################################################################################################
iplocal=$(ifconfig  | grep 'inet addr' | awk '{print $2}' | cut -d ':' -f2 |grep -v 127)
alias make="make -j $(nproc)"
#################################################################################################
start=$(date +%s)
(
#
echo "Starting download of installation of Java"
sleep 1
echo "Unpacking installation files"
sleep 2
sudo apt-get update -y
sudo apt-get install dialog pv cron nano aptitude mlocate python-software-properties debconf-utils sudo software-properties-common -y
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu hardy-security main multiverse" -y 
sudo add-apt-repository -y ppa:webupd8team/java -y
sudo apt-get update -y
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer -y
sleep 2
echo "Starting download of installation of CSP"
sleep 2
cd /lib
sleep 1
mkdir -p cspsvn 
sleep 1
sudo apt-get update -y
sleep 1
apt-get install subversion -y
sleep 1
cd cspsvn 
sleep 1
svn co http://www.streamboard.tv/svn/CSP/trunk CSP-svn
sleep 3
sudo apt-get install ant tar -y
sleep 1
cd CSP-svn 
sleep 1
ant build
sleep 1
ant tar-app
sleep 1
cd dist
sleep 1
tar -zxvf cardservproxy.tar.gz
sleep 1
cd /lib/cspsvn/CSP-svn/dist
sleep 1
mv cardservproxy /usr/local/csp
sleep 1
cd /usr/local/csp
sleep 1
./cardproxy.sh start 
sleep 5
perl -ni.bakbak -e "print unless /com.bowman.cardserv.DcwFilterPlugin/" /usr/local/csp/config/proxy.xml
sleep 2
cd /usr/local/csp
sleep 1
./cardproxy.sh start 
echo "${txtred} Installation Complete, your CSP is ready ! :) ${txtrst}" | pv -qL 30
echo ""
sleep 2
) | tee /var/log/instalation.log
echo "********************************************************" | pv -qL 30
echo "********************************************************" | pv -qL 30
echo "********************************************************" | pv -qL 30
end=$(date +%s)
runtime=$(python -c "print '%u:%02u' % ((${end} - ${start})/60, (${end} - ${start})%60)")
echo -e '\E[37;44m''\033[1m Total Time Runtime = '$runtime' \033[0m'  | pv -qL 30
echo "********************************************************" | pv -qL 30
echo "********************************************************" | pv -qL 30
echo "${txtyellow}More Tutorials Videos at : https://www.youtube.com/channel/UCzXZ7aioVqiN_8P6eht0idg${txtrst}" | pv -qL 30
echo "######################################################" | pv -qL 30
echo "********************************************************" | pv -qL 30
echo "********************************************************" | pv -qL 30
