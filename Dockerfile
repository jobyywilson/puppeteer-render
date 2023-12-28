FROM ghcr.io/puppeteer/puppeteer:19.7.2

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

WORKDIR /usr/src/app

USER root

COPY package*.json ./
RUN npm ci
COPY . .

# Change ownership of /usr/src/app to pptruser
RUN chown -R pptruser:pptruser /usr/src/app

USER pptruser

CMD [ "node", "index.js" ]
