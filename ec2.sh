#install terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

#install golang
wget https://golang.org/dl/go1.15.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
#verfiy go
go version

#install docker
#https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html
sudo amazon-linux-extras install docker
sudo yum install -y  docker
sudo usermod -a -G docker ${USER}
sudo chmod 666 /var/run/docker.sock
sudo systemctl restart docker
#verify docker running
systemctl status docker.service

#install eksctl 
#https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

#install kubectl
#https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.3/2024-04-19/bin/linux/amd64/kubectl
sha256sum -c kubectl.sha256
openssl sha1 -sha256 kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --client

----- Build cluster ---

 #If you assumed a role to create the Amazon EKS cluster, you must ensure that kubectl is configured to assume the same role. 
#Use the following command to update your kubeconfig file to use an IAM role.
#https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
# aws --region <region-code> eks update-kubeconfig --name <cluster_name>
