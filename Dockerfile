FROM node:20

# Create app directory
WORKDIR /usr/src/app

# Copy package manifests
COPY package*.json ./

# Install required system packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl make nmap && \
    rm -rf /var/lib/apt/lists/*

# Install JFrog CLI
RUN curl -fL https://install-cli.jfrog.io | sh

# If you are building your code for production
# ARG JF_TOKEN
# RUN jf c import ${JF_TOKEN} && \
#     jf npmc --repo-resolve=fgr-npm-remote && \
#     jf npm i --omit dev

# Expose application port
# EXPOSE 3000

# Copy application code
COPY server.js ./
COPY public/ public/
COPY views/ views/

# Run the application
CMD [ "node", "server.js" ]
