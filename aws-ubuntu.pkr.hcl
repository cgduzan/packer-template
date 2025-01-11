# Packer commands reference:
# - `packer init .` - initialize the Packer configuration by installing any required plugins
# - `packer fmt .` - format the Packer configuration
# - `packer validate .` - validate the Packer configuration
# - `packer build .` - run the Packer build

# - tell Packer to install plugins required for the source & build steps
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    # - enable this if you want to use the Vagrant post-processor
    # vagrant = {
    #   version = ">= 1.1.1"
    #   source  = "github.com/hashicorp/vagrant"
    # }
  }
}

# - define variables that can be used in the Packer configuration
# - these variables can be set in a "*.auto.pkrvars.hcl" file or passed in via the command line args
variable "ami_prefix" {
  type    = string
  default = "learn-packer-linux-aws-redis"
}

# - locals (a different kind of variable) are evaluated at runtime and cannot be modified (like variables)
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

# - define a source block that specifies the source AMI to build on top of
source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.ami_prefix}-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

# - multiple source blocks can be defined and used to run builds in parallel
source "amazon-ebs" "ubuntu-focal" {
  ami_name      = "${var.ami_prefix}-focal-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}


# - define a build block that specifies the steps to take to create the AMI
build {
  name = "learn-packer"
  sources = [
    # specify the difference sources here to run builds in parallel
    "source.amazon-ebs.ubuntu",
    "source.amazon-ebs.ubuntu-focal"
  ]

  # - provisioners are used to install software onto the machine prior to turning it into an AMI
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Installing Redis",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install -y redis-server",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }

  provisioner "shell" {
    inline = ["echo This provisioner runs last"]
  }

  # - post-processors can be used to run additional steps after the build is complete
  # - these won't modify the build itself, but can be used to upload artifacts, etc.
  # post-processor "vagrant" {}

  # - if you want to run multiple post-processors steps in sequence, you can use a post-processor block
  # post-processors {
  #   post-processor "vagrant" {}
  #   post-processor "compress" {}
  # }

}
