# Loco Assignment README - Tanvir Singh

### My test bench
MacBook Pro M2 running MacOS 13. I'm mentioning this as M series (ARM based)  chips require some hacking around to get Minikube with Ingress working.

### Prerequisites 
1. You're running Minikube on your machine
2. Minikube has metrics-server enabled for HPA to run  `minikube addons enable metrics-server`
3. Minikube has ingress enabled `minikube addons enable ingress`
4. If you're running MacOS on M1/M2, you can follow this blog [here](https://medium.com/@sushantkumarsinha22/kubernetes-setting-up-ingress-on-apple-silicon-mac-m1-5fb6bddcb838) to get Minikube up and running properly with `qemu` 
5. (Optional) Apache benchmark installed for testing HPA.

### Components 
1. Deployment - deploys the image with replicas set to 3
2. Service - this is a ClusterIP listening on port 8080 and pointing to the app inside the container on port 7000
3. HPA - Min replicas set to 3, max replicas set to 5 and targetCPUUtilizationPercentage set to 60%
4. Ingress - It is listening on port 80 for  `loco.private.xyz` ,  forwards requests to the service `loco` on port 8080.

### Testing
I used apache benchmark to trigger the HPA. 100000 requests with 100 concurrent requests.

`ab -n 100000 -c 100 http://loco.private.xyz/`

I've supplied `benchmark.sh` to quickly run this command.

### How to run this demo

1. Make sure the prerequisites are met
2. Depending on your system, you may have to add the `minikube ip` or `127.0.0.1` with `loco.private.xyz` to the `/etc/hosts` . This demo should run fine on Linux but may run into an issue like I did on MacOS for which I've supplied solutions.
3. Run the `install.sh`. This builds the image with the Minikube docker and then installs the required K8s components required to run the application.
4. Run `benchmark.sh` to scale the HPA.

#### Things to watch out for
1. If the Ingress isn't assigned an IP address, please wait.
2. If the DNS isn't resolving, you may need check Minikube config or the `/etc/hosts`

