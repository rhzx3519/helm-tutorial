# implement service dependency by init container

```shell
# build wait image
docker built -t rhzx3519/wait .
```

# examples
```shell
cd examples

# create a serviceaccount used in your pod to get jobs
kubectl apply -f jobs-reader.yaml

# launch your myapp pod which is dependent on dep service
# you can see myapp pod's status is init until dep service accessible
kubectl apply -f myapp.yaml

# launch dependent job
kubectl apply -f dep-job.yaml

# launch dependent service
kubectl apply -f dep-pod.yaml

# you can see myapp pod'status becoming ready finally.
```