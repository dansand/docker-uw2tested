FROM underworldcode/underworld2-dev
MAINTAINER mansourjohn@gmail.com

# set working directory to /root
WORKDIR /root

# run tests
RUN cd underworld2/utils         && \
    /usr/local/bin/tini -- xvfbrun.sh ./testNotebook.py TestDocTests.ipynb ../docs/tutorials/*

WORKDIR /workspace

