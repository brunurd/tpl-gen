ifeq ($(ENV),dev)
    ENV_TYPE = dev
		# set to "dev" unless defined in calling shell
		TF_DIR := $(or $(TF_DIR),"dev")
endif
ifeq ($(ENV),stg)
    ENV_TYPE = staging
		# set to "staging" unless defined in calling shell
		TF_DIR := $(or $(TF_DIR),"staging")
endif
ifeq ($(ENV),prd)
    ENV_TYPE = prod
		# set to "prod" unless defined in calling shell
		TF_DIR := $(or $(TF_DIR),"prod")
endif

TGT_DIR := $(or $(TGT_DIR),"spectralha-api")
