FROM underworldcode/base:latest
MAINTAINER sonderfjord@gmail.com

## set working directory to /root
WORKDIR /root

# setup environment
ENV PYTHONPATH $PYTHONPATH:/root/underworld2

# get underworld, compile, delete some unnecessary files, trust notebooks, copy to workspace
RUN git clone --branch "master" --single-branch https://github.com/underworldcode/underworld2 && \
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
    rm -fr Solvers               && \
    find /root/underworld2/docs -name \*.ipynb  -print0 | xargs -0 jupyter trust && \
    mkdir /workspace                                                 && \
    rsync -av /root/underworld2/docs/examples /workspace             && \
    rsync -av /root/underworld2/docs/user_guide /workspace           && \
    rsync -av /root/underworld2/docs/publications /workspace
    
RUN git clone  https://github.com/dansand/slippy2 && \
    cd slippy2                   && \
    pip install -e .             && \
        cd ..                    && \
    pip install \
        easydict \
        naturalsort \
        networkx \
        pint
        
RUN pip install \
        scipy

# expose notebook port
EXPOSE 8888
# expose glucifer port
EXPOSE 9999

# setup space for working in
VOLUME /workspace/user_data
WORKDIR /workspace

# launch notebook
CMD ["jupyter", "notebook", " --no-browser"]

# launch notebook
#CMD ["jupyter", "notebook", " --no-browser"]
