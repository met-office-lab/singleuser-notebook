FROM pangeo/notebook:2d5c8b4

#####################################################################
# Root                                                              #
#####################################################################

USER root

# Install system packages
RUN apt-get update -y && apt-get install -y ssh libgl1-mesa-glx

# Install jupyter server extentions
RUN jupyter labextension install @jupyterlab/hub-extension @jupyterlab/plotly-extension jupyterlab_bokeh


#####################################################################
# User                                                              #
#####################################################################

USER $NB_USER

# Install extra Python 3 packages
RUN conda install --yes \
    -c conda-forge \
    -c scitools \
    -c bioconda \
    boto3  \
    cartopy \
    plotly \
    fusepy \
    iris \
    nc-time-axis \
    jupyter_dashboards \
    nbpresent \
    && conda clean --tarballs -y

# Add Pete's fork of iris with lazy RMS 3/8/18. Remove after Iris 2.2.
RUN pip install --upgrade \
    https://github.com/dkillick/iris/archive/lazy_rms_agg.zip
