# datapipeline

# Steps to run Kafka Producer and Consumer

1.  Install Kafka and Zookeeper.

2.  Start Zookeeper server by moving into the bin folder of Zookeeper installed directory by using the zkServer.sh start command.
 cd /Users/sassao/case-study/zookeeper-3.4.6/bin/
 ./zkServer.sh start
  Other Zookeeper commans are:
  ./zkServer.sh stop
  ./zkServer.sh status

3. Start Kafka server by moving into the bin folder of Kafka installed directory by using the command.
   cd /Users/sassao/case-study/kafka_2.10-0.9.0.1/bin
   ./kafka-server-start.sh ../config/server.properties

4. Run clean package command from datapipeline folder
   cd /Users/sassao/datapipeline/
   mvn clean install

5. Run Kafka Producer and Consumer as below
java -cp target/data-pipeline-1.0.0-SNAPSHOT.jar com.casestudy.kafka.KafkaTwitterProducer
java -cp target/data-pipeline-1.0.0-SNAPSHOT.jar com.casestudy.kafka.KafkaConsumer

6. We can also check for the topics on which Kafka is running now, using the command.
./kafka-topics.sh -zookeeper localhost:2181 -list

7. We can check the Consumer console simultaneously as well, to check the tweets collected in real-time using, the below command.
./kafka-console-consumer.sh -zookeeper localhost:2181 -topic "twitter-topic1" -from-beginning


