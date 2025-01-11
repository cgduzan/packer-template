# Packer - AWS Template
This is a [Packer (Hashicorp)](https://developer.hashicorp.com/packer) template to use for quick reference. It creates AMI's in AWS.

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

Once completed (will take ~5-10 minutes), you should have 2 new images in your AMI instances in the `us-west-2` region (assuming you haven't changed the config).

## Packer commands reference

| Command | Description |
| --- | --- |
| `packer init .` | Initialize the Packer configuration by installing any required plugins |
| `packer fmt .` | Format the Packer configuration |
| `packer validate .` | Validate the Packer configuration |
| `packer build .` | Build the image(s) |
