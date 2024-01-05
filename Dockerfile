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

# Install Postgres, and gnupg
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib gnupg

# Install Docker
RUN apt-get update
RUN apt-get install -y ca-certificates curl gnupg
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update

RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Don't forget to mount unix:///var/run/docker.sock