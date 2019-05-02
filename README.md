= PLED deployment =

NOTE: {icon cog spin} Under construction {icon cog spin}

The content of this repository is based on Erik Hjelmås' "Kubernetes lab exercise" found at his [Github repository](https://github.com/githubgossin/IaC-heat-k8s).

***

This is a Heat template to launch the PLED service. 

Clone and launch in OpenStack with e.g.
```
# make sure you have security groups called default and linux
# edit pled_top_env.yaml and enter name of your keypair
git clone ssh://git@git.ncr.ntnu.no/source/PLED_deployment.git

cd PLED_deployment
openstack stack create pled_service -t pled_top.yaml -e pled_top_env.yaml
```