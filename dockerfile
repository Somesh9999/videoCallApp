FROM ubuntu:18.04

# MAINTAINER "m.shaikh4@dxc.com"


RUN apt-get update && \
    apt-get install -yq vim nano wget curl git zip nginx
ENV NVM_DIR /usr/local/nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
ENV NODE_VERSION v14.15.0
ENV PORT=3000
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH
# Note - need to copy google-services, platform, pluggins manually in future need to push this folders to git repository
COPY package*.json ./
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "server.js"]