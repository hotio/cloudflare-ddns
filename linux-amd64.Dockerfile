FROM cr.hotio.dev/hotio/base@sha256:f16b2df0fbefceb0978488fb4a17221819668504b8fd47b675b65e50b074c1c4

ENV INTERVAL=300 DETECTION_MODE="dig-whoami.cloudflare" LOG_LEVEL=3

ARG APPRISE_VERSION
RUN apk add --no-cache python3 py3-six py3-requests py3-pip py3-cryptography ncurses iproute2 bind-tools && \
    pip3 install --no-cache-dir --upgrade apprise==${APPRISE_VERSION} && \
    apk del --purge py3-pip

COPY root/ /
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/

RUN chmod 755 "${APP_DIR}/cloudflare-ddns.sh"
