## Infrastructure
Setting up AWS infrastructure using `terraform`. Running the scripts create following layout

- VPC, to span all the subnets
- Subnet 1, in AZ1
- Subnet 2, in AZ2
- Subnet 3, in AZ3

### TODO
- naming convention for extensibility
- IAM roles and access control for VPC and subnets
- define tiers
- different/same VPC for prod/dev/test
    - permissions to be set accordingly
