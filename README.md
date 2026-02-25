# Usage
First, download the Dockerfile and navigate to where it is. Then build using the following command:

```bash
docker build -t [your image name] . 
```

Now you can run using the following command which also mounts the files from your current directory:

```bash
docker run -it --rm --privileged --security-opt seccomp:unconfined --network host -v "${PWD}:/ctf" [your image name]
```

Set an alias inside of .bashrc if you want quick access to the environment e.g 
```bash
echo 'alias pwn-env="docker run -it --rm --privileged --security-opt seccomp:unconfined --network host -v \"\${PWD}:/ctf\" pwn-env"' >> ~/.bashrc
```
