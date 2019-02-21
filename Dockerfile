#FROM underworldcode/underworld2:2.5.1b_magnus
FROM underworldcode/underworld2:dev
MAINTAINER d.sandiford@unimelb.edu

# Dan dependencies
WORKDIR /opt

RUN pip3 install networkx
RUN pip3 install easydict
RUN pip3 install naturalsort
RUN pip3 install "networkx==1.11"
RUN pip3 install pint
RUN pip3 install pandas





ENV UW2_DIR /opt/underworld2

RUN cd /opt && \
    rm -fr underworld2 && \
    git clone --branch "slade" https://github.com/underworldcode/underworld2


RUN cd underworld2/libUnderworld && \
    ./configure.py --with-debugging=0 --petsc-dir=/opt/petsc --hdf5-dir=/opt/petsc && \
    ./compile.py

# copy this file over so that no password is required
#COPY jupyter_notebook_config.json /home/root/.jupyter/jupyter_notebook_config.json

RUN git clone https://github.com/dansand/UWsubduction.git

# change user and update pythonpath
ENV PYTHONPATH $PYTHONPATH:$UW2_DIR
#ENV PYTHONPATH /workspace/user_data/UWGeodynamics:$PYTHONPATH
ENV PYTHONPATH /opt/UWsubduction:$PYTHONPATH

# move back to workspace directory
WORKDIR /workspace

# launch notebook
CMD ["jupyter", "notebook", "--ip='*'", "--no-browser"]
