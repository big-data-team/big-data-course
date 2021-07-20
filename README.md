# About
Practice Course on Big Data
* https://bigdatateam.org/big-data-course

# Spark Configuration

Use port_1 and port_2 provided to you during the class.

In case you would like to run Jupyter notebook interface for pyspark, at first, you need to launch Jupyter:
```bash
jupyter notebook --port=port_1
```

As soon as you launch notebook, you can start PySpark with the help of the forllowing configuration:

```python
from pyspark import SparkConf, SparkContext

spark_conf = (
    SparkConf()
    .set("spark.ui.port", port_2)
    .set("spark.driver.memory", "512m")
    .set("spark.executor.instances", "2")
    .set("spark.executor.cores", "1")
    .setAppName("your shiny name")
    .setMaster("yarn")
)
sc = SparkContext(conf=spark_conf)
```

You will be able to use the same code snippet for spark-submit.

Use the following shortuct to start interactive Jupyter Pyspark session (set Python v.3.6 as the default version):
```bash
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_PYTHON=python3.6 PYSPARK_DRIVER_PYTHON_OPTS='notebook --port=port_1' pyspark --conf spark.ui.port=port_2 --driver-memory 512m --master yarn --num-executors 2 --executor-cores 1
```

## Spark Notes

You usually use "brain-master" for ssh forwarding. Be cautions about "localhost" in the following code snippet.
Add the following rule for ssh forwarding:
```
-L port_1:localhost:port_1 
```

Open the following URL in you favourite browser:
* http://localhost:port_1


Spark Streaming and Kafka will require to add extra flags:
```
--packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0
```
see more details at:
* https://spark.apache.org/docs/latest/structured-streaming-kafka-integration.html

Spark Cassandra will require two following flags:
```
--packages com.datastax.spark:spark-cassandra-connector_2.11:2.4.2
--conf spark.cassandra.connection.host=brain-node1
```

Useful Spark documentation links:
* PySpark: https://spark.apache.org/docs/2.4.7/api.html
* Python API: https://spark.apache.org/docs/2.4.7/api/python/index.html
* PySpark SQL API: https://spark.apache.org/docs/2.4.7/api/python/pyspark.sql.html
