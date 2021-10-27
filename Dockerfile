FROM debian:buster as common

#12.18.3
ARG NODE_VERSION=12.14.1
ENV NODE_VERSION $NODE_VERSION
ENV YARN_VERSION 1.22.5

# Common deps
RUN apt-get update && \
    apt-get -y install build-essential \
                       curl \
                       git \
                       gpg \
                       python \
                       wget \
                       xz-utils \
                       sudo \
                       libsecret-1-dev \
                       make \
                       gcc \
                       pkg-config \
                       libx11-dev \
                       libxkbfile-dev \
    && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

## User account
RUN adduser --disabled-password --gecos '' theia && \
    adduser theia sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers



#Install Yarn
#RUN apt remove cmdtest
#RUN apt remove yarn
RUN /bin/bash -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - '
RUN /bin/bash -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'
RUN apt update 
RUN apt install yarn -y
RUN yarn install


# Install nvm for theia with node and npm

USER theia
WORKDIR /home/theia
RUN mkdir .nvm
ENV NVM_DIR=/home/theia/.nvm
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh| bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN git clone https://github.com/eclipse-theia/theia tmp
RUN mv tmp/* ./
RUN rm -rf tmp

#RUN . $NVM_DIR/nvm.sh

RUN . $NVM_DIR/nvm.sh && \
    . $NVM_DIR/bash_completion && \
    yarn && \
	yarn download:plugins 
	#&& \
	#yarn theia build

#RUN . $NVM_DIR/nvm.sh && \
#  . $NVM_DIR/bash_completion && \
RUN	yarn browser build 


RUN mkdir -p /home/theia/project

EXPOSE 3000

# Configure Theia
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins

ENTRYPOINT [ "node", "/home/theia/examples/browser/src-gen/backend/main.js", "/home/theia/project", "--hostname=0.0.0.0" ]
