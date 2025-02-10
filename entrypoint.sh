#!/bin/bash
set -e

echo "Starting Postfix..."
service postfix start

echo "Starting Dovecot..."
service dovecot start

echo "Starting OpenDKIM & OpenDMARC..."
service opendkim start
service opendmarc start

echo "Starting Rspamd..."
service rspamd start

tail -f /var/log/mail.log
