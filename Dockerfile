ARG NODE_VERSION
FROM node:${NODE_VERSION}

RUN apt-get update && apt-get install -y build-essential curl
