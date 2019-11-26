FROM    dreamkas-rf-compiler:latest

RUN     apt-get install -y sudo
ADD     /fisgo/Libraries tmp/FisGo
WORKDIR /tmp/FisGo
RUN     ./deployLibs.bash 1 n