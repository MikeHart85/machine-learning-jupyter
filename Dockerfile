FROM ubuntu:16.04

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        graphviz \
        libpng16-16 \
        libjpeg-turbo8 \
        libgomp1 \
        openssl \
        python3 \
        python3-pip \
    && BUILD_DEPS="\
        build-essential \
        cmake \
        curl \
        git \
        python3-dev \
        tcl-dev \
        xz-utils \
        zlib1g-dev \
        " \
    && apt-get install -y --no-install-recommends $BUILD_DEPS \
    && pip3 install --upgrade pip==9.0.1 \
    && pip3 install --upgrade setuptools wheel \
    && pip3 install --upgrade \
        cffi \
        graphviz \
        h5py \
        ipywidgets \
        jupyter \
        jupyterlab \
        keras \
        matplotlib \
        numpy \
        pandas \
        pillow \
        pymkl \
        pyyaml \
        requests \
        scikit-learn \
        scipy \
        seaborn \
        tensorflow \
        xgboost \
        http://download.pytorch.org/whl/cpu/torch-0.3.1-cp35-cp35m-linux_x86_64.whl \
        torchvision \
    && jupyter nbextension enable --py widgetsnbextension \
    && jupyter serverextension enable --py jupyterlab \
    && apt-get remove --purge --auto-remove -y $BUILD_DEPS \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/.cache/pip/* \
    && find /usr/lib/python3 -name __pycache__ | xargs rm -r \
    && find / \( -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' +

# COPY /copyroot /

WORKDIR /notebooks

CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", "--port=8888", \
     "--no-browser", "--allow-root", \
     "--NotebookApp.token="]
