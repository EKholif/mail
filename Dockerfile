FROM opensuse/leap:latest

LABEL maintainer="admin@fungigrotto.com"

# Update system and install required packages
RUN zypper --non-interactive clean --all && \
    zypper --non-interactive refresh && \
    zypper --non-interactive update && \
    zypper --non-interactive install -y \
        postfix \
        dovecot \
        opendkim \
        opendmarc \
        rspamd \
        mariadb-client \
        telnet && \
    zypper clean --all && \
    rm -rf /var/lib/zypp /var/cache/zypp

# Copy configuration files
COPY config/postfix /etc/postfix/
COPY config/dovecot /etc/dovecot/
COPY config/rspamd /etc/rspamd/

# Set permissions
RUN chmod -R 644 /etc/postfix/* /etc/dovecot/* /etc/rspamd/*

# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25 465 587 993 995

CMD ["/entrypoint.sh"]
