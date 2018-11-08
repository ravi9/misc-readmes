#### Install Prereqs

https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

  ```
  pip install awscli
  aws configure
  ```


#### Download eksctl tool and move into your PATH
```bash
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
```

#### Install aws-iam-authenticator for Amazon EKS
https://docs.aws.amazon.com/eks/latest/userguide/configure-kubectl.html

Save `aws-iam-authenticator` as `heptio-authenticator-aws` as required by eksctl.
```bash
curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
chmod 777 heptio-authenticator-aws
sudo mv heptio-authenticator-aws /usr/local/bin
```

#### Confirm installation
    eksctl version

#### Install kubectl
https://kubernetes.io/docs/tasks/tools/install-kubectl/

##### Ubuntu, Debian Install instructions
```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

##### CentOS, RHEL, Fedora Install Instructions
```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```
#### Verify kubectl installation
```
kubectl version
```

#### Create a test cluster
For more command line options see https://github.com/weaveworks/eksctl
```bash
eksctl create cluster \
--name=test-cluster \
--nodes=3 \
--node-type=c4.xlarge \
--node-ami=auto \
--ssh-access  --ssh-public-key=my_aws_key
--region=us-west-2 
```

##### It about 15min to create a cluster. Example output from https://github.com/weaveworks/eksctl
```
$ eksctl create cluster
2018-10-26T16:22:17+01:00 [ℹ]  using region us-west-2
2018-10-26T16:22:19+01:00 [ℹ]  setting availability zones to [us-west-2a us-west-2b us-west-2c]
2018-10-26T16:22:19+01:00 [ℹ]  subnets for us-west-2a - public:192.168.0.0/19 private:192.168.96.0/19
2018-10-26T16:22:19+01:00 [ℹ]  subnets for us-west-2b - public:192.168.32.0/19 private:192.168.128.0/19
2018-10-26T16:22:19+01:00 [ℹ]  subnets for us-west-2c - public:192.168.64.0/19 private:192.168.160.0/19
2018-10-26T16:22:19+01:00 [ℹ]  using "ami-0a54c984b9f908c81" for nodes
2018-10-26T16:22:19+01:00 [ℹ]  creating EKS cluster "floral-unicorn-1540567338" in "us-west-2" region
2018-10-26T16:22:19+01:00 [ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial nodegroup
2018-10-26T16:22:19+01:00 [ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-west-2 --name=floral-unicorn-1540567338'
2018-10-26T16:22:19+01:00 [ℹ]  creating cluster stack "eksctl-floral-unicorn-1540567338-cluster"
2018-10-26T16:33:03+01:00 [ℹ]  creating nodegroup stack "eksctl-floral-unicorn-1540567338-nodegroup-0"
2018-10-26T16:36:44+01:00 [✔]  all EKS cluster resource for "floral-unicorn-1540567338" had been created
2018-10-26T16:36:44+01:00 [✔]  saved kubeconfig as "/Users/ilya/.kube/config"
2018-10-26T16:36:46+01:00 [ℹ]  the cluster has 0 nodes
2018-10-26T16:36:46+01:00 [ℹ]  waiting for at least 2 nodes to become ready
2018-10-26T16:37:22+01:00 [ℹ]  the cluster has 2 nodes
2018-10-26T16:37:22+01:00 [ℹ]  node "ip-192-168-25-215.us-west-2.compute.internal" is ready
2018-10-26T16:37:22+01:00 [ℹ]  node "ip-192-168-83-60.us-west-2.compute.internal" is ready
2018-10-26T16:37:23+01:00 [ℹ]  kubectl command should work with "~/.kube/config", try 'kubectl get nodes'
2018-10-26T16:37:23+01:00 [✔]  EKS cluster "floral-unicorn-1540567338" in "us-west-2" region is ready
```

#### Verify cluster
```
kubectl get nodes
```
#### Delete a Cluster
	eksctl delete cluster --name=<name> [--region=<region>]
