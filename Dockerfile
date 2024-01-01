FROM ubuntu:22.04 as base

# Install Go
RUN apt-get update && apt-get install -y wget git xz-utils
RUN wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN go version

# Install go modules relevant to the project
RUN git clone https://github.com/programme-lv/backend.git
RUN cd backend && go mod download

# Install Node, NPM, and Yarn
RUN wget https://nodejs.org/dist/v21.5.0/node-v21.5.0-linux-x64.tar.xz
RUN tar -xf node-v21.5.0-linux-x64.tar.xz
RUN mv node-v21.5.0-linux-x64 /usr/local/node
ENV PATH=$PATH:/usr/local/node/bin
RUN node -v
RUN npm -v
RUN npm install -g yarn
