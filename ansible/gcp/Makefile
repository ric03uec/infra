ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
INVENTORY_DIR := /ansible/inventories
PLAYBOOKS_DIR := /ansible/playbooks

.PHONY: all

all: staging_info

staging_info:
	$(info *** Printing staging environment info ***)
	# call vpc, subnet etc recursively

staging_provision: staging_provision_vpc
	$(info *** Provisioning staging environment ***)

staging_deprovision: staging_deprovision_vpc

staging_provision_vpc:
	$(info *** Provisioning staging environment VPC ***)
	docker run \
		-v $(ROOT_DIR):/ansible \
		ric03uec/cansible:master -vvv \
		$(PLAYBOOKS_DIR)/network_prov.yml

staging_deprovision_vpc:
	$(info *** Deprovisioning staging environment VPC ***)
	docker run \
		-v $(ROOT_DIR):/ansible \
		ric03uec/cansible:master -vvv \
		$(PLAYBOOKS_DIR)/network_deprov.yml
