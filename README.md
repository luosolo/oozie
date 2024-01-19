Apache Oozie
=============

About this fork
--------------

This is a fork of the 5.2.1 tag that compiles with Hadoop 3.3.6. It also defines the necessary steps to create the Dockerfile and a configuration for a development environment that includes:

. Namenode
. Datanode
. Resourcemanager
. Oozie

#Compile
> mvn clean package assembly:single -DskipTests -Dhadoop.version=3.3.6 -Dhadoop.majorversion=3 -Phadoop3,hadoop-3,uber,spark-2

# Building the Dockerfile

To build the Dockerfile, run the following command:

> docker build -t bigflow:latest .

This will create a Docker image named "__bigflow:latest__".




What is Oozie
--------------

Oozie is an extensible, scalable and reliable system to define, manage, schedule, and execute complex Hadoop workloads via web services. More specifically, this includes:

  * XML-based declarative framework to specify a job or a complex workflow of dependent jobs.
  * Support different types of job such as Hadoop Map-Reduce, Pipe, Streaming, Pig, Hive and custom java applications.
  * Workflow scheduling based on frequency and/or data availability.
  * Monitoring capability, automatic retry and failure handing of jobs.
  * Extensible and pluggable architecture to allow arbitrary grid programming paradigms.
  * Authentication, authorization, and capacity-aware load throttling to allow multi-tenant software as a service.

Oozie Overview
----------

Oozie is a server based Workflow Engine specialized in running workflow jobs with actions that run Hadoop Map/Reduce and Pig jobs.

Oozie is a Java Web-Application that runs in a Java servlet-container.

For the purposes of Oozie, a workflow is a collection of actions (i.e. Hadoop Map/Reduce jobs, Pig jobs) arranged in a control dependency DAG (Directed Acyclic Graph). "control dependency" from one action to another means that the second action can't run until the first action has completed.

Oozie workflows definitions are written in hPDL (a XML Process Definition Language similar to JBOSS JBPM jPDL).

Oozie workflow actions start jobs in remote systems (i.e. Hadoop, Pig). Upon action completion, the remote systems callback Oozie to notify the action completion, at this point Oozie proceeds to the next action in the workflow.

Oozie workflows contain control flow nodes and action nodes.

Control flow nodes define the beginning and the end of a workflow ( start , end and fail nodes) and provide a mechanism to control the workflow execution path ( decision , fork and join nodes).

Action nodes are the mechanism by which a workflow triggers the execution of a computation/processing task. Oozie provides support for different types of actions: Hadoop map-reduce, Hadoop file system, Pig, SSH, HTTP, eMail and Oozie sub-workflow. Oozie can be extended to support additional type of actions.

Oozie workflows can be parameterized (using variables like ${inputDir} within the workflow definition). When submitting a workflow job values for the parameters must be provided. If properly parameterized (i.e. using different output directories) several identical workflow jobs can concurrently.

Documentations :
-----------------
Oozie web service is bundle with the built-in details documentation.

More inforamtion could be found at:
http://oozie.apache.org/

Oozie Quick Start:
http://oozie.apache.org/docs/5.2.1/DG_QuickStart.html


Supported Hadoop Versions:
----------------------------

This version of Oozie was primarily tested against Hadoop 2.4.x and 2.6.x.



If you have any questions/issues, please send an email to:

user@oozie.apache.org

Subscribe using the link:

http://oozie.apache.org/mail-lists.html
