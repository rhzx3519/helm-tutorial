# implement service dependency by init container

```shell
# build wait image
docker built -t rhzx3519/wait .
```

# examples
```shell
cd examples
# launch your myapp pod which is dependent on dep service
# you can see myapp pod's status is init until dep service accessible
kubectl apply -f myapp.yaml

# launch dep service
kubectl apply -f dependency.yaml

# you can see myapp pod'status becoming ready finally.
```