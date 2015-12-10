FROM underworldcode/underworld2-dev
MAINTAINER mansourjohn@gmail.com

# set working directory to /root
WORKDIR /root/underworld2/utils

# run tests
RUN xvfbrun.sh ./testNotebook.py TestDocTests.ipynb ../docs/tutorials/* ../docs/test/*.ipynb 

WORKDIR /workspace

# launch notebook
CMD ["jupyter", "notebook"]
