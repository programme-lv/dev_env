FROM cruizba/ubuntu-dind:jammy-24.0.7

WORKDIR /dockerfile

# Install Go
RUN apt-get update && apt-get install -y wget git xz-utils
RUN wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN go version

# Install Node, NPM, and Yarn
RUN wget https://nodejs.org/dist/v21.5.0/node-v21.5.0-linux-x64.tar.xz
RUN tar -xf node-v21.5.0-linux-x64.tar.xz
RUN mv node-v21.5.0-linux-x64 /usr/local/node
ENV PATH=$PATH:/usr/local/node/bin
RUN node -v
RUN npm -v
RUN npm install -g yarn

# Install Postgres, and gnupg
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib gnupg

# Preinstall dependencies for go
RUN git clone https://github.com/programme-lv/backend.git
RUN cd backend && go mod download

# Preinstall dependencies for node
RUN git clone https://github.com/programme-lv/website.git
RUN cd website && yarn install

# Install flyway
ARG FLYWAY_URL=https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.4.1/flyway-commandline-10.4.1-linux-x64.tar.gz
RUN wget -qO- ${FLYWAY_URL} | tar -xvz && ln -s `pwd`/flyway-10.4.1/flyway /usr/local/bin 

ENTRYPOINT ["entrypoint.sh"]
CMD ["sleep", "infinity"]