# big-data-course
Practice course on Big Data

```bash
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --NotebookApp.token= --port=port_1' pyspark2 --conf spark.ui.port=port_2 --driver-memory 512m --master yarn --num-executors 2 --executor-cores 1
```
