# Packer - AWS Template
This is a Packer (Hashicorp) template to use for quick reference. It creates AMI's in AWS.

The `aws-ubuntu.pkr.hcl` config file was built following [Packer's AWS tutorial](https://developer.hashicorp.com/packer/tutorials/aws-get-started/get-started-install-cli). I've added comments in the file to describe the different components of Packer and how they're utilized.

# Running Packer
‼️ Note: running this temporarily provisions EC2 instances and stores AMI snapshots which could cost money. I suggest creating/utilizing an AWS free-tier account to minimize any costs.

## Prerequisites
- [Install Packer](https://developer.hashicorp.com/packer/tutorials/aws-get-started/get-started-install-cli#installing-packer)
- [Instal AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (assuming you already have an AWS account)

## Run it!
Clone the repo & navigate to the directory:
```
git clone https://github.com/cgduzan/packer-template.git && \
cd packer-template
```
Validate the config file: (it should already be good, but just so you know the command)
```
packer validate .
```
Install required plugins:
```
packer init .
```
Build the image(s):
```
packer build .
```

## Packer commands reference

`packer init .` - initialize the Packer configuration by installing any required plugins

`packer fmt .` - format the Packer configuration

`packer validate .` - validate the Packer configuration

`packer build .` - run the Packer build
