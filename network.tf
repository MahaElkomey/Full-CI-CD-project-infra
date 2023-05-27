module "my_network" {
    source = "./network"

    vpc-cidr = var.VPC_CIDR

    public-subnet-1-cidr = var.PUBLIC_SUBNET_1_CIDR

    public-subnet-2-cidr = var.PUBLIC_SUBNET_2_CIDR

    private-subnet-1-cidr = var.PRIVATE_SUBNET_1_CIDR

    private-subnet-2-cidr = var.PRIVATE_SUBNET_2_CIDR

    az-1 = var.AZ_1

    az-2 = var.AZ_2

    AMI_ID = var.AMI_ID

    INSTANCE_TYPE = var.INSTANCE_TYPE

}