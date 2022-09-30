import subprocess
from itertools import islice
from enoslib.api import generate_inventory,run_ansible
from enoslib.infra.enos_vmong5k.provider import VMonG5k
from enoslib.infra.enos_vmong5k.configuration import Configuration

import logging
from pathlib import Path

import enoslib as en

import logging
import time

name = "member"

clusters = "paravance"

site = "rennes"

#logging.basicConfig(level=logging.DEBUG)

master_nodes = []

duration = "05:00:00"

prod_network = en.G5kNetworkConf(type="prod", roles=["my_network"], site=site)

name_job = name + clusters

role_name = "cluster" + str(clusters)

conf = (
    en.G5kConf.from_settings(job_type="allow_classic_ssh", job_name=name_job)
    .add_network_conf(prod_network)
    .add_network(
        id="not_linked_to_any_machine", type="slash_22", roles=["my_subnet"], site=site
    )
    .add_machine(
    roles=["role1"], cluster=clusters, nodes=1, primary_network=prod_network
    )
    .finalize()
)
provider = en.G5k(conf)
roles, networks = provider.init()
roles = en.sync_info(roles, networks)

subnet = networks["my_subnet"][0]
cp = 1
w=20
virt_conf = (
    en.VMonG5kConf.from_settings(image="/grid5000/virt-images/ubuntu2004-x64-min-2022032913.qcow2")
    .add_machine(
        roles=["cp"],
        number=cp,
        undercloud=roles["role1"],
        flavour_desc={"core": 2, "mem": 8192},
        macs=list(islice(en.mac_range(subnet), cp))
    .add_machine(
        roles=["member"],
        number=w,
        undercloud=roles["role1"],
        flavour_desc={"core": 1, "mem": 4096},
        macs=list(islice(en.mac_range(subnet), w))
    ).finalize()
)
)

vmroles = en.start_virtualmachines(virt_conf)

print(vmroles)

print(networks)

inventory_file = "kubefed_inventory_cluster" + ".ini" 

inventory = generate_inventory(roles, networks, inventory_file)

master_nodes.append(roles[role_name][0].address)

# Make sure k8s is not already running
#run_ansible(["reset_k8s.yml"], inventory_path=inventory_file)
time.sleep(30)
# Deploy k8s and dependencies
run_ansible(["deploy_system.yml"], inventory_path=inventory_file)

f = open("node_list", 'a')
f.write(str(master_nodes[0]))
f.write("\n")
f.close

print("Master nodes ........")
print(master_nodes)