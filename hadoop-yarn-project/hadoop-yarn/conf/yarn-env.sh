#
# #
# AUTO-GENERATED, please try not to change it
# Time:  2021-12-14_05:52:53UTC
# Build: https://ltx1-jenkins.grid.linkedin.com:8443/job/hadoop-sre/job/grid-conf_batch-build/57/
# JIRA:  GRID-89384
#
#

# Set JAVA_HOME
export JAVA_HOME=/usr/java/default
export PATH=$JAVA_HOME/bin:$PATH # just to be extra sure

# User for YARN daemons
export HADOOP_YARN_USER=${HADOOP_YARN_USER:-yarn}

# resolve links - $0 may be a softlink
export YARN_CONF_DIR="${YARN_CONF_DIR:-$HADOOP_YARN_HOME/conf}"

# log dir
export YARN_LOG_DIR="${YARN_LOG_DIR:=/export/apps/hadoop/logs}"

# Heap dump path
export NODEMANAGER_HEAP_DUMP_PATH="/export/home/yarn/nodemanager-heapdump.bin"
export NODEMANAGER_ERROR_FILE="/export/home/yarn/nodemanager.jvm.err"

# For setting YARN specific HEAP sizes please use this
# Parameter and set appropriately
YARN_HEAPSIZE=1024

# check envvars which might override default args
if [ "$YARN_HEAPSIZE" != "" ]; then
  JAVA_HEAP_MAX="-Xmx""$YARN_HEAPSIZE""m"
fi

# GC and JMX
export HADOOP_GENERIC_GCFLAGS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+ParallelRefProcEnabled"
export HADOOP_BIG_GCFLAGS="-XX:ParallelGCThreads=12 -XX:+UseConcMarkSweepGC -XX:NewSize=5G -XX:MaxNewSize=5G -XX:CMSInitiatingOccupancyFraction=84 -XX:+UseCMSInitiatingOccupancyOnly -XX:+PrintTenuringDistribution -XX:+PrintGCApplicationStoppedTime"
export HADOOP_GENERIC_JMXFLAGS="-Dcom.sun.management.jmxremote=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

# Clients
export YARN_CLIENT_OPTS="-Xmx128m $YARN_CLIENT_OPTS"

# GRID-3943: changes for spark external shuffle jar location
if [ -d /export/apps/hadoop/nodemanager/site/sparklib ]; then
    export YARN_USER_CLASSPATH="/export/apps/hadoop/nodemanager/site/sparklib/*"
fi

#
# Resource Manager
#
YARN_RESOURCEMANAGER_OPTS="-Xmx31g -Xms31g -Dyarn.server.resourcemanager.appsummary.log.file=rm-appsummary.log -Dyarn.server.resourcemanager.appsummary.logger=INFO,HRMSUMMARY -Dyarn.server.resourcemanager.preemption.logger=DEBUG,preemption -Dyarn.server.resourcemanager.elasticity.logger=INFO,elasticity -Xloggc:${YARN_LOG_DIR}/gc-rm.log-$(date +'%Y%m%d%H%M') -Dhadoop.root.logger=INFO,HRFA -Dyarn.root.logger=INFO,HRFA -Dyarn.server.resourcemanager.containersummary.log.file=rm-containersummary.log -Dyarn.server.resourcemanager.containersummary.logger=INFO,RMCONTSUMMARY ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_BIG_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS}"

#
# Proxy Server
YARN_PROXYSERVER_OPTS="-Xmx1g -Xloggc:${YARN_LOG_DIR}/gc-wp.log-$(date +'%Y%m%d%H%M') -Dyarn.root.logger=INFO,HRFA -Dhadoop.root.logger=INFO,HRFA ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS}"

#
# Node Manager

YARN_NODEMANAGER_OPTS="-Xmx5g -Xms512m -Xloggc:${YARN_LOG_DIR}/gc-nm.log-$(date +'%Y%m%d%H%M') -Dyarn.root.logger=INFO,DRFA -Dhadoop.root.logger=INFO,DRFA ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS} -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${NODEMANAGER_HEAP_DUMP_PATH} -XX:ErrorFile=${NODEMANAGER_ERROR_FILE}"

#
#Router

HADOOP_ROUTER_OPTS="-Xmx5g -Xms5g -Xloggc:${YARN_LOG_DIR}/gc-router.log-$(date +'%Y%m%d%H%M') ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_BIG_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS}"

# default log directory & file
if [ "$YARN_LOG_DIR" = "" ]; then
  YARN_LOG_DIR="$HADOOP_YARN_HOME/logs"
fi
if [ "$YARN_LOGFILE" = "" ]; then
  YARN_LOGFILE='yarn.log'
fi

# Pid DIR
export YARN_PID_DIR="${YARN_PID_DIR:=/export/apps/hadoop/pids}"

# default policy file for service-level authorization
if [ "$YARN_POLICYFILE" = "" ]; then
  YARN_POLICYFILE="hadoop-policy.xml"
fi

YARN_OPTS="$YARN_OPTS -Dhadoop.log.dir=$YARN_LOG_DIR"
YARN_OPTS="$YARN_OPTS -Dyarn.log.dir=$YARN_LOG_DIR"
YARN_OPTS="$YARN_OPTS -Dhadoop.log.file=$YARN_LOGFILE"
YARN_OPTS="$YARN_OPTS -Dyarn.log.file=$YARN_LOGFILE"
YARN_OPTS="$YARN_OPTS -Dyarn.home.dir=$YARN_COMMON_HOME"
YARN_OPTS="$YARN_OPTS -Dyarn.id.str=$YARN_IDENT_STRING"
YARN_OPTS="$YARN_OPTS -Dhadoop.root.logger=${YARN_ROOT_LOGGER:-INFO,console}"
YARN_OPTS="$YARN_OPTS -Dyarn.root.logger=${YARN_ROOT_LOGGER:-INFO,console}"
YARN_OPTS="$YARN_OPTS -Dyarn.policy.file=$YARN_POLICYFILE"
YARN_OPTS="$YARN_OPTS -Djava.net.preferIPv4Stack=true"
if [ "x$JAVA_LIBRARY_PATH" != "x" ]; then
  YARN_OPTS="$YARN_OPTS -Djava.library.path=$JAVA_LIBRARY_PATH"
fi
export YARN_OPTS
