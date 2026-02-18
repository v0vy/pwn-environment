# Usage
First, download the Dockerfile and navigate to where it is. Then build using the following command:

```sh
docker build -t [your image name] . 
```

Now you can run using the following command which also mounts the files from your current directory:

```
docker run -it --rm --privileged --security-opt seccomp:unconfined --network host -v "${PWD}:/ctf" [your image name]
```
