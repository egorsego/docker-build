FROM    dreamkas-rf-compiler:latest

RUN     apt-get install -y sudo
ADD     /FisGo tmp/FisGo
WORKDIR /tmp/FisGo
RUN     ls -la
WORKDIR /tmp/FisGo/Libraries
RUN     ls -la
RUN     ./deployLibs.bash 1 n
RUN     ls -la
WORKDIR /tmp/FisGo
RUN     ls -la