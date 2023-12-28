FROM ghcr.io/puppeteer/puppeteer:19.7.2

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

WORKDIR /usr/src/app


# Create a non-root user without adding to lastlog and faillog databases
RUN useradd -u 1001 --no-log-init -r -g 0 -m -d /usr/src/app appuser

# Give permissions to the non-root user
RUN chown -R 1001:0 /usr/src/app

USER 1001

COPY package*.json ./
RUN npm ci
COPY . .
CMD [ "node", "index.js" ]

