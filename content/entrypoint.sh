#!/bin/sh

if [[ "${PUID}" = "0" ]] && [[ "${PGID}" = "0" ]]; then
    chown -R /etc/service
    ln -s /.aria2allinoneworkdir/service/* /etc/service/ 2>/dev/null
    exec runsvdir -P /etc/service
else
    mkdir -p /mnt/data/downloads /mnt/data/finished 2>/dev/null
    chown -R ${PUID}:${PGID} /.aria2allinoneworkdir /mnt/config /etc/service 2>/dev/null
    chown ${PUID}:${PGID} /mnt/data /mnt/data/downloads /mnt/data/finished
    su-exec ${PUID}:${PGID} ln -s /.aria2allinoneworkdir/service/* /etc/service/ 2>dev/null
    exec su-exec ${PUID}:${PGID} runsvdir -P /etc/service
fi
