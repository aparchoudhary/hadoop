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

export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/etc/hadoop"}
export HADOOP_SITE_DIR=${HADOOP_CONF_DIR%%/etc/hadoop}
[[ -z "$HADOOP_SITE_DIR" ]] && HADOOP_SITE_DIR=$HADOOP_CONF_DIR
export JSVC_HOME=$HADOOP_SITE_DIR/jsvc

#
# Logging
#
export HADOOP_LOG_DIR="${HADOOP_LOG_DIR:=/export/apps/hadoop/logs}"

#
# Class Path
#   Insert site libs (grid topology)
#
for f in $HADOOP_SITE_DIR/lib/*.jar; do
  if [ "$HADOOP_CLASSPATH" ]; then
    export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$f
  else
    export HADOOP_CLASSPATH=$f
  fi
done

#
# Native Libraries
#   Add site native libraries to JAVA/LD Path
#
if [ "x$JAVA_LIBRARY_PATH" == "x" ]; then
  export JAVA_LIBRARY_PATH=$HADOOP_HOME/lib/native:$HADOOP_SITE_DIR/lib/native
else
  export JAVA_LIBRARY_PATH=$HADOOP_HOME/lib/native:$HADOOP_SITE_DIR/lib/native:$JAVA_LIBRARY_PATH
fi

# The maximum amount of heap to use, in MB. Default is 1000.
export HADOOP_HEAPSIZE=1024

# Extra Java runtime options.  All javas get this
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true"

# GC and JMX
export HADOOP_GENERIC_GCFLAGS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+ParallelRefProcEnabled"
export HADOOP_BIG_GCFLAGS="-XX:+UseLargePages -XX:+UseLargePagesInMetaspace -XX:ParallelGCThreads=12 -XX:+UseConcMarkSweepGC -XX:NewSize=72G -XX:MaxNewSize=72G -XX:CMSInitiatingOccupancyFraction=84 -XX:+UseCMSInitiatingOccupancyOnly -XX:ConcGCThreads=6 -XX:+PrintTenuringDistribution -XX:+PrintGCApplicationStoppedTime -XX:+CMSConcurrentMTEnabled -XX:+CMSParallelRemarkEnabled -XX:+UseCondCardMark -XX:+UnlockDiagnosticVMOptions -XX:ParGCCardsPerStrideChunk=32768"
export HADOOP_GENERIC_JMXFLAGS="-Dcom.sun.management.jmxremote=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

#
# Client
#
export HADOOP_CLIENT_OPTS="-Xmx128m $HADOOP_CLIENT_OPTS -Dconn.logs.additivity=false -Djava.io.tmpdir=/grid/a/tmp/hadoop-$USER"


#
# Namenode
#
export HADOOP_NAMENODE_OPTS="-Xmx390g -Xms390g -Xloggc:${HADOOP_LOG_DIR}/gc-nn.log-$(date +'%Y%m%d%H%M') -Dhadoop.root.logger=INFO,HRFA -Dconn.logs.additivity=true -Dhadoop.security.logger=INFO,HRFAS -Dhadoop.security.log.file=hdfs-auth-$(hostname).log -Dhdfs.audit.logger=INFO,HRFAAUDIT -Dhadoop.audit.log.file=hdfs-audit-$(hostname).log  -Djava.util.logging.config.file=logging.properties ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_BIG_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS}"

#
# Secondary Namenode
#
export HADOOP_SECONDARYNAMENODE_OPTS="-Xmx390g -Xms390g -Xloggc:${HADOOP_LOG_DIR}/gc-sn.log-$(date +'%Y%m%d%H%M') -Dhadoop.root.logger=INFO,HRFA -Dconn.logs.additivity=true -Dhadoop.security.logger=INFO,HRFAS -Dhadoop.security.log.file=hdfs-auth-$(hostname).log ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_BIG_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS}"

#
# Datanode
#
export HADOOP_DATANODE_OPTS="-Xms4g -Xmx4g -Xloggc:${HADOOP_LOG_DIR}/gc-dn.log-$(date +'%Y%m%d%H%M') -Dhadoop.root.logger=INFO,DRFA -Dconn.logs.additivity=true -Dhadoop.security.logger=INFO,DRFAS ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS} -server -XX:+UseAES -XX:+UseAESIntrinsics"

export HADOOP_JOURNALNODE_OPTS="-Xmx4g -Xloggc:${HADOOP_LOG_DIR}/gc-jn.log-$(date +'%Y%m%d%H%M') -Dhadoop.root.logger=INFO,DRFA -Dconn.logs.additivity=true -Dhadoop.security.logger=INFO,DRFAS ${HADOOP_GENERIC_GCFLAGS} ${HADOOP_GENERIC_JMXFLAGS}"

# On secure datanodes, user to run the datanode as after dropping privileges
export HADOOP_SECURE_DN_USER=hdfs

# Where log files are stored in the secure data environment.
export HADOOP_SECURE_DN_LOG_DIR=${HADOOP_LOG_DIR}/${HADOOP_HDFS_USER}

# The directory where pid files are stored. /tmp by default.
# NOTE: this should be set to a directory that can only be written to by
#       the user that will run the hadoop daemons.  Otherwise there is the
#       potential for a symlink attack.
export HADOOP_PID_DIR=/export/apps/hadoop/pids
export HADOOP_SECURE_DN_PID_DIR=${HADOOP_PID_DIR}

# A string representing this instance of hadoop. $USER by default.
export HADOOP_IDENT_STRING=$USER

# for slaves.sh
export HADOOP_SSH_OPTS="-o IdentityFile=~/.ssh/id_rsa -o IdentityFile=~/.ssh/id_dsa -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=10s"