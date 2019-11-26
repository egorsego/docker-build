FROM    dreamkas-rf-compiler:latest

RUN     apt-get install -y sudo
ADD     . /tmp/FisGo
WORKDIR /tmp/FisGo/Libraries
RUN     ./deployLibs.bash 1 n
WORKDIR /tmp/FisGo
RUN ls -la