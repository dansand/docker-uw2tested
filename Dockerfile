
FROM underworldcode/underworld2_untested:dev_magnus_newmpi
MAINTAINER sand@student.unimelb.edu

RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        python-tk
        
        
# Dan dependencies
WORKDIR /opt 

RUN pip install networkx
RUN pip install easydict 
RUN pip install naturalsort
RUN pip install "networkx==1.11"
RUN pip install pint
RUN pip install pandas


RUN git clone https://github.com/dansand/UWsubduction.git

# change user and update pythonpath
ENV PYTHONPATH $PYTHONPATH:$UW2_DIR
#ENV PYTHONPATH /workspace/user_data/UWGeodynamics:$PYTHONPATH
ENV PYTHONPATH /opt/UWsubduction:$PYTHONPATH

# move back to workspace directory
WORKDIR /workspace
