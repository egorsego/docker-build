FROM    dreamkas-sf-library:latest

ENV     PATH=/usr/local/arm_linux_4.8/bin:${PATH}
ENV     LD_LIBRARY_PATH=/usr/local/usr/lib/
WORKDIR /tmp/FisGo/build
RUN     cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=On ..
RUN     make -j4