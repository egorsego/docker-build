FROM    dreamkas-rf-compiler:latest

RUN     apt-get install -y sudo
ADD     /FisGo tmp/FisGo
WORKDIR /tmp/FisGo/Libraries
RUN     ./deployLibs.bash 1 n