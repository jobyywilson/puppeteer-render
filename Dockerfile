FROM ghcr.io/puppeteer/puppeteer:19.7.2

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

WORKDIR /usr/src/app

# Use the existing non-root user in the base image
USER pptruser

COPY package*.json ./
RUN npm ci
COPY . .
CMD [ "node", "index.js" ]

