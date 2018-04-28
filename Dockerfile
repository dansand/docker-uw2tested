FROM underworldcode/underworld2_untested:slade
MAINTAINER d.sandiford@unimelb.edu

# Dan dependencies
WORKDIR /opt

RUN pip install networkx
RUN pip install easydict 
RUN pip install naturalsort
RUN pip install "networkx==1.11"
RUN pip install pint
RUN pip install pandas

ENV UW2_DIR /opt/underworld2

# copy this file over so that no password is required
#COPY jupyter_notebook_config.json /home/root/.jupyter/jupyter_notebook_config.json

# change user and update pythonpath
ENV PYTHONPATH $PYTHONPATH:$UW2_DIR
ENV PYTHONPATH /workspace/user_data/UWGeodynamics:$PYTHONPATH

# move back to workspace directory
WORKDIR /workspace

# launch notebook
CMD ["jupyter", "notebook", "--ip='*'", "--no-browser"]
