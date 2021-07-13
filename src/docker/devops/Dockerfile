FROM ubuntu:20.04

ARG UID
ARG GID

ENV PRODUCT_NAME="min-jinja"
ENV PRODUCT_DIR="/opt/min-jinja"
ENV USR="ubuntu"
ENV GRP="ubuntu"
ENV HOME="/home/$USR"
ENV TERM="xterm-256color"
ENV TZ="Etc/UTC"
VOLUME $PRODUCT_DIR

ENV TERM="xterm-256color"
ENV TZ="Etc/UTC"

# Workaround to interactive keyboard issue.
RUN echo \n\
XKBMODEL="pc105" \n\
XKBLAYOUT="se" \n\
XKBVARIANT="" \n\
XKBOPTIONS="" \n\
BACKSPACE="guess" \n\
 > /etc/default/keyboard

# Install Ubuntu 20.04 os utils.
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get upgrade -y && \
   apt-get install -y --no-install-recommends apt-utils
RUN export DEBIAN_FRONTEND=noninteractive && ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
   apt-get install -y --no-install-recommends tzdata && \
   dpkg-reconfigure --frontend noninteractive tzdata
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y \
        lsb-release sudo curl net-tools wget \
        git zip unzip build-essential linux-headers-5.4.0-1037-aws \
        perl make vim ufw jq snapd debconf-utils dialog telnet

# Install python binaries.
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y python3-pip python3-distutils python3-testresources \
      python3.8-dev python3.8-venv
RUN ln -sfn /usr/bin/python3.8 /usr/bin/python
RUN ln -sfn /usr/bin/python3.8 /usr/bin/python3
RUN export DEBIAN_FRONTEND=noninteractive && apt-get clean all && apt-get install --fix-missing

# Enable host to container edit of project code on ubuntu and mac.
RUN test -z $(getent group $GID | cut -d: -f1) || \
      groupmod -g $((GID+1000)) $(getent group $GID | cut -d: -f1)

RUN addgroup --gid $GID $GRP
RUN adduser \
      --gid $GID \
      --shell "/bin/bash" \
      --home "/home/$USR" \
      --uid $UID \
      $USR && exit 0

RUN echo "$USR:9748#d4Aj" | chpasswd
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER $USR
ENV USER=$USR
ENV GROUP=$GRP

USER ubuntu
ENV USER=ubuntu

# Create volume inside image.
ADD --chown=$USR:$GRP "." "$PRODUCT_DIR"
WORKDIR $PRODUCT_DIR

# Install poetry.
RUN ./run -a do_check_install_poetry

CMD exec /bin/bash -c "./run -a do_check_install_python_modules ; trap : TERM INT; sleep infinity & wait"
