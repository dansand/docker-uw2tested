FROM underworldcode/base:latest
MAINTAINER mansourjohn@gmail.com

# set working directory to /root
WORKDIR /root

# setup environment
ENV PYTHONPATH $PYTHONPATH:/root/underworld2

# get underworld, compile, delete some unnecessary files, run tests.
RUN git clone https://github.com/underworldcode/underworld2 && \
    cd underworld2/libUnderworld && \
    ./configure.py               && \
    ./scons.py                   && \
    cd libUnderworldPy           && \
    ./swigall.py                 && \
    cd ..                        && \
    ./scons.py                   && \
    rm .sconsign.dblite          && \
    rm -fr .sconf_temp           && \
    cd build                     && \
    rm -fr libUnderworldPy       && \
    rm -fr StGermain             && \
    rm -fr gLucifer              && \
    rm -fr Underworld            && \
    rm -fr StgFEM                && \
    rm -fr StgDomain             && \
    rm -fr PICellerator          && \
    rm -fr Solvers

# copy underworld examples over
RUN mkdir /workspace && \
    rsync -av /root/underworld2/docs/examples /workspace

# expose notebook port
EXPOSE 8888

# setup space for working in
VOLUME /workspace
WORKDIR /workspace

# launch notebook
#CMD ["jupyter", "notebook", " --no-browser"]
