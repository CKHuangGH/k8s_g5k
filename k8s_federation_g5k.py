import subprocess
from enoslib.api import discover_networks, generate_inventory,run_ansible
from enoslib.infra.enos_vmong5k.provider import VMonG5k
from enoslib.infra.enos_vmong5k.configuration import Configuration

import logging
import time

name = "kube2-"

clusters = ["paravance", "paravance"]

#logging.basicConfig(level=logging.DEBUG)

master_nodes = []

duration = "04:00:00"


for i in range(0, len(clusters)):

    name_job = name + clusters[i] + str(i)

    role_name = "cluster" + str(clusters[i])
    
    conf = Configuration.from_settings(job_name=name_job,
                                       walltime=duration,
                                       image="/grid5000/virt-images/ubuntu2004-x64-min-2022032913.qcow2")\
                        .add_machine(roles=[role_name],
                                     cluster=clusters[i],
                                     flavour_desc={"core": 4, "mem": 8192},
                                     number=2)\
                        .finalize()
    provider = VMonG5k(conf)

    roles, networks = provider.init()

    roles = discover_networks(roles, networks)

    inventory_file = "kubefed_inventory_cluster" + str(i) + ".ini" 

    inventory = generate_inventory(roles, networks, inventory_file)

    master_nodes.append(roles[role_name][0].address)

    # Make sure k8s is not already running
    #run_ansible(["reset_k8s.yml"], inventory_path=inventory_file)

    # Deploy k8s and dependencies
    run_ansible(["deploy_system.yml"], inventory_path=inventory_file)

    # Deploy k8s and dependencies
    
    #run_ansible(["deploy_k8s.yml"], inventory_path=inventory_file)



# Master nodes of each cluster


# Modify k8s conctext configurations to give them unique names
subprocess.check_call("./modify_kube_config.sh %s %s" % (str(master_nodes[0]), str(master_nodes[1])), shell=True)

# Setup Kubernetes Federation with Cluster 0 as the host cluster and the remaining clusters as members of the federation
#run_ansible(["kubefed_init.yml"], inventory_path="kubefed_inventory_cluster0.ini")

print("Master nodes ........")
print(master_nodes)
