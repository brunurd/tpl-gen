FROM python:3.8-alpine

ARG ENV
ARG UID
ARG GID
ARG PRODUCT
ARG TGT_ORG

ENV PRODUCT=$PRODUCT
ENV TGT_ORG=$TGT_ORG
ENV APPUSR=appusr
ENV APPGRP=appgrp
ENV PS1='`date "+%F %T"` \u@\h  \w \n\n  '
ENV PRODUCT_DIR="/opt/$PRODUCT"
ENV EDITOR="vim"
ENV ENV=$ENV
ENV TERRAFORM_REQUIRED_VERSION="1.0.1"

VOLUME $PRODUCT_DIR

# install OS utils
RUN apk update && apk upgrade && apk add --no-cache \
      bash binutils vim perl jq wget curl zip unzip busybox-extras su-exec sudo shadow bash util-linux

# install backend-utils
RUN apk update && apk upgrade && apk add --no-cache \
      build-base gcc openssl-dev libmagic ttf-freefont musl-dev libxslt-dev libxml2-dev \
      jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev




# start ::: adding OS APPUSR and APPGRP
RUN test -z $(getent group $GID | cut -d: -f1) || \
      groupmod -g $((GID+1000)) $(getent group $GID | cut -d: -f1)

# create a APPGRP and APPUSR
RUN set -x ; addgroup -g "$GID" -S "$APPGRP" && \
      adduser \
      --disabled-password \
      -g "$GID" \
      -D \
      -s "/bin/bash" \
      -h "/home/$APPUSR" \
      -u "$UID" \
      -G "$APPGRP" "$APPUSR" && exit 0 ; exit 1

RUN echo "$APPUSR ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "export PS1=\"$PS1\"" >> /home/$APPUSR/.bashrc


# install python3 utils
RUN wget https://bootstrap.pypa.io/get-pip.py ; sudo python3 get-pip.py ; sudo rm -v get-pip.py
RUN apk update && apk upgrade && apk add --no-cache \
      python3-dev py3-setuptools

RUN pip install virtualenv pybabel twine

# add project folder
ADD --chown=$APPUSR:$APPGRP "." /home/$APPUSR$PRODUCT_DIR

USER $APPUSR
# stop ::: adding OS APPUSR and APPGRP

# install poetry
RUN bash /home/$APPUSR/$PRODUCT_DIR/run -a do_check_install_py_modules

WORKDIR $PRODUCT_DIR

# CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
CMD exec /bin/bash -c "src/bash/run/docker-init-tpl-gen.sh"
