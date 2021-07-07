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

# start ::: workaround the interactive keyboard problem
RUN echo \n\
XKBMODEL="pc105" \n\
XKBLAYOUT="se" \n\
XKBVARIANT="" \n\
XKBOPTIONS="" \n\
BACKSPACE="guess" \n\
 > /etc/default/keyboard
# stop ::: workaround the interactive keyboard problem

# start ::: ubuntu 20.04 os utils
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get upgrade -y && \
   apt-get install -y --no-install-recommends apt-utils
RUN export DEBIAN_FRONTEND=noninteractive && ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
   apt-get install -y --no-install-recommends tzdata && \
   dpkg-reconfigure --frontend noninteractive tzdata
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y \
        lsb-release sudo curl net-tools wget \
        git zip unzip build-essential linux-headers-5.4.0-1037-aws \
        perl make vim ufw jq snapd debconf-utils dialog telnet
# stop  ::: ubuntu 20.04 os utils

# start ::: install python bins
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y python3-pip python3-distutils python3-testresources \
      python3.8-dev python3.8-venv
RUN ln -sfn /usr/bin/python3.8 /usr/bin/python
RUN ln -sfn /usr/bin/python3.8 /usr/bin/python3
RUN export DEBIAN_FRONTEND=noninteractive && apt-get clean all && apt-get install --fix-missing
# stop ::: install python bins

# start ::: enable host to container edit of proj code on ubuntu and mac.
RUN test -z $(getent group $GID | cut -d: -f1) || \
      groupmod -g $((GID+1000)) $(getent group $GID | cut -d: -f1)

RUN addgroup --gid $GID $GRP
RUN adduser \
      --gid $GID \
      --shell "/bin/bash" \
      --home "/home/$USR" \
      --uid $UID \
      $USR && exit 0

RUN echo "$USR:1432@lAFk" | chpasswd
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER $USR
ENV USER=$USR
ENV GROUP=$GRP

USER ubuntu
ENV USER=ubuntu
# stop  ::: enable host to container edit of proj code on ubuntu and mac.


ADD --chown=$USR:$GRP "." "/home/ubuntu/$PRODUCT_DIR"

# start install python modules via poetry
WORKDIR /home/ubuntu/$PRODUCT_DIR/src/python/min-jinja
ENV PYTHONPATH=${PYTHONPATH}:${PWD}
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
ENV PATH="$HOME/.poetry/bin:${PATH}"
RUN poetry config virtualenvs.create false && poetry install --no-dev
# stop install python modules via poetry

WORKDIR $PRODUCT_DIR
CMD exec /bin/bash -c "./run -a do_check_install_python_modules ; trap : TERM INT; sleep infinity & wait"
