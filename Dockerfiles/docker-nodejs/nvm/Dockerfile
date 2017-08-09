FROM alpine:3.6
MAINTAINER Ivan Sebastian Ortega "isortegah@gmail.com"
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 8.2.1

RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python 

ENV YARN_VERSION 0.27.5

RUN apk add --no-cache --virtual .build-deps-yarn curl gnupg tar \
  && for key in \
    6A010C5166006599AA17F08146C2130DFD2497F5 \
  ; do \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
  done \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
  && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && mkdir -p /opt/yarn \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && apk del .build-deps-yarn

RUN apk add --update bash && rm -rf /var/cache/apk/*
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


# Install nvm with node and npm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.11.2
RUN touch ~/.bashrc
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION 
#    && nvm alias default $NODE_VERSION \
#    && nvm use default

#ENV NODE_PATH  $NVM_DIR/v$NODE_VERSION/lib/node_modules
#ENV PATH       $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#RUN npm version

# Configuración para Heroku
#RUN mkdir -p /app /app/.profile.d
#ENV PATH /app/user/node_modules/.bin:/usr/local/bin:$PATH
#WORKDIR /app/user
#RUN echo "export PATH=\"/usr/local/bin:/app/user/node_modules/.bin:\$PATH\"" > /app/.profile.d/nodejs.sh