FROM    dreamkas-sf-library:latest

ENV     PATH=/usr/local/arm_linux_4.8/bin:${PATH}
ENV     LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/usr/lib/
WORKDIR /tmp/FisGo
RUN     sed 's/#add_definitions(-DG_UNIT)/add_definitions(-DG_UNIT)/g' -i CMakeLists.txt
WORKDIR /tmp/FisGo/build
RUN     cmake ..
RUN     make -j4