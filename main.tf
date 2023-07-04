terraform {
        required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "4.16"

}

}
required_version = ">= 1.2.0"

}

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAUF2O4HCY3TWWKLTR"
  secret_key = "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"
}

resource "aws_instance" "my_ec2_instance" {
        count = 1
        ami = "ami-024e6efaf93d85776"
        instance_type = "t2.micro"
        tags = {
                Name = "TerraformBatch"
}


}

output "ec2_public_ips" {
        value = aws_instance.my_ec2_instance[*].public_ip

}
