FROM ubuntu

MAINTAINER ich777

RUN apt-get update
RUN apt-get -y install lib32gcc1 wget

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV GAME_NAME="template"
ENV GAME_PARAMS="template"
ENV GAME_PORT=3724
ENV GAME_MODE="Creative"
ENV MOD_LAUNCHER="false"
ENV WU_SERVERNAME="DockerServer"
ENV WU_PWD="Docker"
ENV WU_ADMINPWD=""
ENV WU_MAXPLAYERS=100
ENV WU_QUERYPORT=27020
ENV WU_HOMESERVER=""
ENV WU_HOMEKINGDOM=0
ENV WU_LOGINSERVER="true"
ENV WU_EPICSERVERS="false"
ENV VALIDATE=""
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""

RUN mkdir $DATA_DIR
RUN mkdir $STEAMCMD_DIR
RUN mkdir $SERVER_DIR
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID steam
RUN chown -R steam $DATA_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R steam /opt/scripts

USER steam

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]
