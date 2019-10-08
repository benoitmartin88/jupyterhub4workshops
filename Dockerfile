FROM jupyterhub/jupyterhub

ENV BASH_ENV ~/.bashrc
SHELL ["/bin/bash", "-c"]

RUN pip install jupyterlab jupyterhub-nativeauthenticator

# install scikitlearn kernel
RUN conda create -n scikitlearn python=3.6
RUN . /opt/conda/etc/profile.d/conda.sh \
  && conda activate scikitlearn \
  && conda install -c conda-forge ipykernel scikit-learn matplotlib numpy \
  && python -m ipykernel install --name=scikitlearn --display-name=scikitlearn --prefix=/opt/conda

# set shared_data folder
RUN ln -s /shared_data /etc/skel/shared_data

# copy and run bootstrap
ADD data/bootstrap.sh /root/bootstrap.sh

ENTRYPOINT /root/bootstrap.sh
