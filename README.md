# big-data-course
Practice course on Big Data

Use the following comand to start PySpark:
```bash
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --NotebookApp.token= --port=port_1' pyspark2 --conf spark.ui.port=port_2 --driver-memory 512m --master yarn --num-executors 2 --executor-cores 1
```

With Py3.6 default:
```bash
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_PYTHON=python3.6 PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --NotebookApp.token= --port=port_1' pyspark2 --conf spark.ui.port=port_2 --driver-memory 512m --master yarn --num-executors 2 --executor-cores 1
```
