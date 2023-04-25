# syntax=docker/dockerfile:1
FROM node:18.16.0-alpine3.17 AS base

RUN \
  --mount=type=cache,target=/var/cache/apk -- \
  apk -U upgrade && \
  apk add --no-cache \
    coreutils \
    jq \
    yarn \
    git \
    curl \
    bash \
    openssh \
    sudo

# >>>>>>>>>>>>>>>> STAGE 1 [BASE] <<<<<<<<<<<<<<<<<<

FROM base AS environment
WORKDIR /home/node/app

RUN corepack enable && corepack prepare pnpm@latest --activate

RUN \
  echo "node ALL=(ALL) ALL" > /etc/sudoers.d/node && \
  chmod 0440 /etc/sudoers.d/node

RUN \
  mkdir -p /home/node/.pnpm-store && \
  mkdir -p /home/node/app \
  mkdir -p /home/node/app/node_modules \
  mkdir -p /home/node/app/dist

RUN chown -R node:node /home/node

USER node

# >>>>>>>>>>>>>>>> STAGE 2 [ENVIRONMENT] <<<<<<<<<<<<<<<<<<

FROM environment AS development

ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

RUN git config --global --add safe.directory .

# Comment 
RUN echo "->> Setting up the development environment. "