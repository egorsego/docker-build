FROM    dreamkas-rf-compiler:latest

RUN     apt-get install -y sudo
RUN     pwd
RUN     ls -la
ADD     . /tmp/FisGo
WORKDIR /tmp
RUN     ls -la
WORKDIR /tmp/FisGo
RUN     ls -la
WORKDIR /tmp/FisGo/Libraries
RUN     ./deployLibs.bash 1 n
WORKDIR /tmp/FisGo
RUN     ls -la