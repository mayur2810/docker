FROM openjdk:8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends net-tools curl netcat

ENV HADOOP_VERSION 2.7.4
ENV HADOOP_URL https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ENV SPARK_VERSION 2.4.4
ENV SPARK_URL http://apache.mirrors.nublue.co.uk/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

ENV USER=root
ENV PATH $HADOOP_PREFIX/bin/:$PATH

RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
    && rm /tmp/spark.tar.gz*

RUN ln -s /opt/spark-$SPARK_VERSION-bin-hadoop2.7/conf /etc/spark
RUN cp /etc/spark/spark-defaults.conf.template /etc/spark/spark-defaults.conf
RUN cp /etc/spark/spark-env.sh.template /etc/spark/spark-env.sh
RUN mkdir /opt/spark-$SPARK_VERSION-bin-hadoop2.7/logs

ENV SPARK_PREFIX=/opt/spark-$SPARK_VERSION-bin-hadoop2.7
ENV SPARK_CONF_DIR=/etc/spark
ENV PATH $SPARK_PREFIX/bin/:$PATH

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV SPARK_HOME=/opt/spark-$SPARK_VERSION-bin-hadoop2.7

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nano
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openssh-server
RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]