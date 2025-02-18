#!/bin/bash  
# ShadowStrike Installer (installer.sh)  
# Author: MIGUEL XZ 
# License: GPL-3.0  

RED='\033[0;31m'  
GREEN='\033[0;32m'  
YELLOW='\033[1;33m'  
NC='\033[0m' # No Color  

echo -e "${RED}  
███████╗██╗  ██╗ █████╗ ██████╗ ██████╗ ██╗    ███████╗████████╗██████╗ ██╗██╗  ██╗███████╗  
██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗██║    ██╔════╝╚══██╔══╝██╔══██╗██║██║ ██╔╝██╔════╝  
███████╗███████║███████║██║  ██║██║  ██║██║    ███████╗   ██║   ██████╔╝██║█████╔╝ █████╗    
╚════██║██╔══██║██╔══██║██║  ██║██║  ██║██║    ╚════██║   ██║   ██╔══██╗██║██╔═██╗ ██╔══╝    
███████║██║  ██║██║  ██║██████╔╝██████╔╝███████╗███████║   ██║   ██║  ██║██║██║  ██╗███████╗  
╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝  
${NC}"  


if ! command -v python3 &> /dev/null; then  
    echo -e "${YELLOW}[!] Python3 não encontrado. Instalando...${NC}"  
    pkg install python -y  
fi  


if ! command -v pip3 &> /dev/null; then  
    echo -e "${YELLOW}[!] Pip3 não encontrado. Instalando...${NC}"  
    pkg install python-pip -y  
fi  


echo -e "${GREEN}[+] Instalando bibliotecas Python...${NC}"  
pip3 install requests stem scapy socks  


if ! command -v tor &> /dev/null; then  
    echo -e "${YELLOW}[!] Tor não encontrado. Instalando...${NC}"  
    pkg install tor -y  
fi  


if ! command -v macchanger &> /dev/null; then  
    echo -e "${YELLOW}[!] Macchanger não encontrado. Instalando...${NC}"  
    pkg install macchanger -y  
fi  


echo -e "${GREEN}[+] Configurando Tor...${NC}"  
mkdir -p ~/.tor  
echo "ControlPort 9051" > ~/.tor/torrc  
echo "HashedControlPassword $(tor --hash-password 'ShadowStrike@1337' | tail -n 1)" >> ~/.tor/torrc  


echo -e "${GREEN}[+] Iniciando Tor...${NC}"  
tor -f ~/.tor/torrc > /dev/null 2>&1 &  


echo -e "${GREEN}[+] Configurando permissões...${NC}"  
chmod +x shadowstrike.py  


echo -e "${GREEN}[+] Instalação concluída!${NC}"  
echo -e "${RED}⚠️ AVISO LEGAL: Use apenas para fins educacionais em ambientes autorizados! ⚠️${NC}"  
echo -e "Execute com: ${YELLOW}python3 shadowstrike.py <ALVO>${NC}"  
