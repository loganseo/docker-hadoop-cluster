FROM apache/hadoop:3.3.6

ARG shared_workspace=/opt/workspace
ARG spark_version=3.5.1

RUN sudo mkdir -p ${shared_workspace} && \
    sudo chown -R hadoop:hadoop ${shared_workspace} && \
    sudo yum update -y && \
    sudo yum install -y python3 && \
    sudo yum install -y python3-pip && \
    sudo yum install -y curl && \
    sudo yum install -y wget

RUN sudo pip3 install --upgrade pip setuptools wheel && \
    sudo pip3 install pandas && \
    sudo pip3 install scikit-learn && \
    sudo pip3 install tensorflow && \
    sudo pip3 install torch && \
    sudo pip3 install jupyter

RUN sudo curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop3.tgz -o spark.tgz && \
    sudo tar zxvf spark.tgz && \
    sudo mv spark-${spark_version}-bin-hadoop3 /opt/spark && \
    sudo rm spark.tgz

ENV PATH="$PATH:/opt/spark/bin"
ENV HADOOP_HOME=/opt/hadoop
ENV SPARK_HOME /opt/spark
ENV PYSPARK_PYTHON python3
ENV PYSPARK_DRIVER_PYTHON jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=0.0.0.0 --port=7777 --no-browser --allow-root"
ENV SHARED_WORKSPACE=${shared_workspace}

WORKDIR ${SPARK_HOME}
CMD ["bash"]