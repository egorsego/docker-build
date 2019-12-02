#!/bin/bash

cd /
rm /FisGo/outf
killall wpa_supplicant
rmmod 8188eu
cd /FisGo 
./fiscat >>/FisGo/outf &