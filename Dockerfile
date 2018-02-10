FROM resin/rpi-raspbian

RUN sudo apt-get update && \
    sudo apt-get install bluetooth bluez bluez-hcidump blueman build-essential libbz2-dev liblzma-dev libsqlite3-dev \
    libncurses5-dev libgdbm-dev zlib1g-dev libreadline-dev libssl-dev tk-dev

RUN cd /tmp && \
    curl -O https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz && \
    tar xzvf Python-3.6.0.tgz && \
    cd Python-3.6.0/ && \
    ./configure && \
    make && \
    sudo make install && \
    cd .. && \
    rm -rf Python*

RUN sudo apt-get --purge remove libbz2-dev liblzma-dev libsqlite3-dev libncurses5-dev && \
    sudo apt-get --purge remove libgdbm-dev zlib1g-dev libreadline-dev libssl-dev tk-dev && \
    sudo apt-get autoremove && \
    sudo apt-get clean

RUN pip3 install --user ruuvitag-sensor aiohttp

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD ruuvi_api.py /usr/src/app

CMD python3 /usr/src/app/ruuvi_api.py