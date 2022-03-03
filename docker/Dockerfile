FROM ubuntu:20.04

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install ca-certificates locales curl gpg -y \
    && locale-gen --no-purge en_US.UTF-8 \
    && apt-get dist-upgrade -y \
    && apt-get install -y gettext-base python3 python3-setuptools python3-dev python3-virtualenv python3-pip python-is-python3 supervisor

COPY ./docker/supervisor/supervisord.conf /etc/supervisor/
COPY ./docker/supervisor/conf.d/*.conf /etc/supervisor/conf.d/

# Final cleanup
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /app /data

COPY ./imaprelay /app

RUN cd / && virtualenv -p /usr/bin/python3 --activators bash /venv \
    && . /venv/bin/activate \
    && python -m pip install -U pip \
    && cd /app && pip install -e ./

# Convenience
RUN echo "source /venv/bin/activate" >> /root/.bashrc

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

COPY ./docker/docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
