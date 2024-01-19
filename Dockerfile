FROM apache/hadoop:3

ARG OOZIE_VERSION=5.2.1
ARG OOZIE_TMP_DIR=/tmp/oozie
ARG OOZIE_HOME=/opt/oozie
ARG HADOOP_HOME=/opt/hadoop
ARG SQL_CONNECTOR_VERSION=5.1.48

RUN sudo yum install zip unzip -y
RUN mkdir -p ${OOZIE_TMP_DIR}
RUN sudo mkdir -p ${OOZIE_HOME}
RUN sudo chown hadoop ${OOZIE_HOME}


WORKDIR ${OOZIE_TMP_DIR}
COPY distro/target/oozie-${OOZIE_VERSION}-distro.tar.gz  .
RUN tar -xzf oozie-${OOZIE_VERSION}-distro.tar.gz && \
mv oozie-${OOZIE_VERSION}/* ${OOZIE_HOME} && \
mkdir ${OOZIE_HOME}/libext &&\
wget http://archive.cloudera.com/gplextras/misc/ext-2.2.zip && \
mv ext-2.2.zip ${OOZIE_HOME}/libext/ &&\
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${SQL_CONNECTOR_VERSION}.tar.gz && \
tar -xzf mysql-connector-java-${SQL_CONNECTOR_VERSION}.tar.gz 
RUN ls mysql-connector-java-${SQL_CONNECTOR_VERSION}/mysql-connector-java-${SQL_CONNECTOR_VERSION}.jar
RUN cp mysql-connector-java-${SQL_CONNECTOR_VERSION}/mysql-connector-java-${SQL_CONNECTOR_VERSION}.jar ${OOZIE_HOME}/libext/ && \
cp ${HADOOP_HOME}/share/hadoop/common/*.jar ${OOZIE_HOME}/libext/ &&\
cp ${HADOOP_HOME}/share/hadoop/common/lib/*.jar ${OOZIE_HOME}/libext/ 
RUN cp ${HADOOP_HOME}/share/hadoop/hdfs/*.jar ${OOZIE_HOME}/libext/ 
RUN cp ${HADOOP_HOME}/share/hadoop/hdfs/lib/*.jar ${OOZIE_HOME}/libext/ && \
cp ${HADOOP_HOME}/share/hadoop/mapreduce/*.jar ${OOZIE_HOME}/libext/ &&\
cp ${HADOOP_HOME}/share/hadoop/yarn/*.jar ${OOZIE_HOME}/libext/ &&\
cp ${HADOOP_HOME}/share/hadoop/yarn/lib/*.jar ${OOZIE_HOME}/libext/ 
#echo "PATH=${JAVA_HOME}/bin:${OOZIE_HOME}/bin:${PATH}" >> ~/.bashrc 
WORKDIR ${OOZIE_HOME}
RUN rm -rf ${OOZIE_TMP_DIR}
RUN sudo mkdir -p /var/log/oozie && sudo chown -R hadoop /var/log/oozie \
&& sudo mkdir -p /var/lib/oozie/data && sudo chown -R hadoop /var/lib/oozie \
&& ln -s /var/log/oozie /opt/oozie/log \
&& ln -s /var/lib/oozie/data /opt/oozie/data


COPY oozie-site.xml ${OOZIE_HOME}/conf/
# ports
EXPOSE 11000 11001
RUN  tar -xvf oozie-examples.tar.gz

COPY run.sh /run.sh
RUN sudo chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]