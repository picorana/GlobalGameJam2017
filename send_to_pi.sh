#!/bin/bash
# RASPIP=10.42.0.72
RASPIP=10.42.0.91	
rsync -avz . pi@$RASPIP:/home/pi/Proyectos/005_V_Chordata/SRC/notochord --exclude *.o --exclude bin/
# scp -r . pi@$RASPIP:/home/pi/Proyectos/005_V_Chordata/SRC/notochord