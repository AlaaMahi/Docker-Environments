FROM jupyter/tensorflow-notebook:5f90f6bd0a50

#Set the working directory
WORKDIR /home/alaa/

# Modules
COPY requirements.txt /home/alaa/requirements.txt
COPY runtime.txt /home/alaa/runtime.txt
RUN apt-get update && apt-get install python3.6.8 && \
    pip install -r /home/alaa/requirements.txt

# Add files
COPY python-binder /home/alaa/python-binder
COPY r-binder /home/alaa/python-binder
COPY README.md /home/alaa/README.md

# Allow user to write to directory
USER root
RUN chown -R $NB_USER /home/alaa \
    && chmod -R 774 /home/alaa \
    && rm -fR /home/alaa/work 
USER $NB_USER

# Expose the notebook port
EXPOSE 8888

# Start the notebook server
CMD jupyter notebook --no-browser --port 8888 --ip=0.0.0.0 --NotebookApp.token='' --NotebookApp.disable_check_xsrf=True --NotebookApp.iopub_data_rate_limit=1.0e10
