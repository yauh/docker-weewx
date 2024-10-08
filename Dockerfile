FROM jgoerzen/debian-base-security:bookworm
MAINTAINER John Goerzen <jgoerzen@complete.org>
COPY setup/ /tmp/setup/
# UPDATE CI ALSO WHEN UPDATING VERSION
ENV WEEWX_VERSION 5.0.2
ENV DEBIAN_FRONTEND noninteractive
# The font file is used for the generated images
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ssh rsync fonts-freefont-ttf fonts-dejavu python3-mysqldb python3-ephem ca-certificates && \
    /tmp/setup/setup.sh && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/www/html/weewx

VOLUME ["/var/lib/weewx"]
CMD ["/usr/local/bin/boot-debian-base"]
