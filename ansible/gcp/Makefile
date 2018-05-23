ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
INVENTORY_DIR := /ansible/gce/inventories
ROLES_DIR := /ansible/roles

.PHONY: all

all: staging-info

staging-info:
	$(info *** Printing staging environment info ***)
	# call vpc, subnet etc recursively

staging-provision: staging-provision-vpc
	$(info *** Provisioning staging environment ***)

staging-provision-vpc:
	$(info *** Provisioning staging environment VPC ***)
	docker run -v $(ROOT_DIR):/ansible \
		ric03uec/cansible:master -vv \
		-i $(INVENTORY_DIR)/staging/hosts \
		$(ROLES_DIR)/common/vpc.yml
