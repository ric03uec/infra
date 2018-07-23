## Infrastructure

Setting up AWS infrastructure using `terraform` and `ansible` on `aws`, `gcp` and `azure`.

### Layout

The scripts will create following infrastructure components on all the clouds.

- VPC, to span all the subnets
    - Subnet 1, in AZ1
    - Subnet 2, in AZ2
    - Subnet 3, in AZ3
- Public facing instance in Subnet 1


### GCP

- to use google cloud cli, use one of the official images from: https://hub.docker.com/r/google/cloud-sdk/
- create a project on GCP
- generate [service accounts](https://cloud.google.com/compute/docs/access/service-accounts) and corresponding keys with restricted access
- login to gcp using service account keys

```
$ docker run --name gcloud-config -v $(pat/to/keys/on/host):/keys/ google/cloud-sdk:196.0.0-alpine gcloud auth activate-service-account --key-file=/keys/<key-file>.json
Activated service account credentials for: [<service-account-name>]
```

- authenticated gcp commands can now be executed from containers
```
$ sudo docker run --volumes-from gcloud-config google/cloud-sdk:196.0.0-alpine gcloud compute images --project <your-project> list
NAME                                                  PROJECT            FAMILY                            DEPRECATED  STATUS
centos-6-v20180716                                    centos-cloud       centos-6                                      READY
centos-7-v20180716                                    centos-cloud       centos-7                                      READY
...
```

### Azure

- to use azure cli, use one of the official images from : https://hub.docker.com/r/microsoft/azure-cli/tags/
### TODO

- naming convention for extensibility
- IAM roles and access control for VPC and subnets
- define tiers
- different/same VPC for prod/dev/test
    - permissions to be set accordingly
