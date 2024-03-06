#!/bin/bash
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
#install
clear
history -c 
rm -fr xbot.sh
rm -fr /usr/bin/xolpanel
rm -fr /usr/bin/panel.zip*
#color
NC='\e[0m'
u="\033[1;36m"
y="\033[1;93m"
g="\033[1;92m"
r="\033[1;91m"

REPO="https://raw.githubusercontent.com/Tikusmerdeka/Backendv6/main/bot/"
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#install
apt update && apt upgrade
apt install neofetch -y
apt install python3 python3-pip git
cd /usr/bin
wget -q -O bot.zip "${REPO}bot.zip"
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -rf bot.zip
clear
wget -q -O panel.zip "${REPO}panel.zip"
unzip panel.zip
pip3 install -r xolpanel/requirements.txt

clear
echo ""
figlet 'faruk' | lolcat
echo -e "$u ┌────────────────────────────────────────────────┐${NC}"
echo -e "$u │ \e[1;97;101m                ADD BOT PANEL                 ${NC} ${u}│${NC}"
echo -e "$u └────────────────────────────────────────────────┘${NC}"
echo -e "$u ┌────────────────────────────────────────────────┐${NC}"
echo -e "$u │ ${g}Tutorial Creat Bot and ID Telegram                   ${NC}"
echo -e "$u │ ${g}Creat Bot and Token Bot : @BotFather                 ${NC}"
echo -e "$u │ ${g}Info Id Telegram : @MissRose_bot perintah /info      ${NC}"
echo -e "$u └────────────────────────────────────────────────┘${NC}"
echo -e ""
read -e -p "  [*] Input your Bot Token : " bottoken
read -e -p "  [*] Input Your Id Telegram : " admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/xolpanel/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/xolpanel/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/xolpanel/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/xolpanel/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/xolpanel/var.txt
clear

if [ -e /etc/systemd/system/panel.service ]; then
echo ""
else
rm -fr /etc/systemd/system/panel.service
fi

cat > /etc/systemd/system/panel.service << END
[Unit]
Description=Simple Bot Tele By - @MAZ_FARUK
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m xolpanel
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start panel
systemctl enable panel
systemctl restart panel
cd

# // STATUS SERVICE BOT
bot_service=$(systemctl status panel | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $bot_service == "running" ]]; then 
   sts_bot="${g}[ON]${NC}"
else
   sts_bot="${r}[OFF]${NC}"
fi

rm -fr /usr/bin/panel.zip
rm -fr /usr/bin/panel.zip
clear
neofetch
echo -e "  ${y} Your Data BOT Info"
echo -e "  ${u}┌───────────────────────────────────┐${NC}"
echo -e "  ${u}│$r Status BOT ${y}=$NC $sts_bot "
echo -e "  ${u}│$r Token BOT  ${y}=$NC $bottoken "
echo -e "  ${u}│$r Admin ID   ${y}=$NC $admin "
echo -e "  ${u}│$r Domain     ${y}=$NC $domain "
#echo -e "  ${u}│$r NS Domain  ${y}=$NC $NS "
echo -e "  ${u}└───────────────────────────────────┘${NC}"
echo -e ""
history -c
read -p "  Press [ Enter ] to back on menu"
menu