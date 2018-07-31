
FROM underworldcode/underworld2_untested:dev_magnus_newmpi
MAINTAINER romain.beucher@unimelb.edu

RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        python-tk
