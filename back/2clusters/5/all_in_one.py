import logging
from pathlib import Path

import enoslib as en

en.init_logging(logging.INFO)

job_name = Path(__file__).name

CLUSTER = "chiclet"

SITE = "lille"

prod_network = en.G5kNetworkConf(type="prod", roles=["my_network"], site=SITE)
conf = (
    en.G5kConf.from_settings(job_type="allow_classic_ssh", job_name=job_name)
    .add_network_conf(prod_network)
    .add_network(
        id="not_linked_to_any_machine", type="slash_22", roles=["my_subnet"], site=SITE
    )
    .add_machine(
        roles=["role1"], cluster=CLUSTER, nodes=1, primary_network=prod_network
    )
    .finalize()
)


provider = en.G5k(conf)
roles, networks = provider.init()
roles = en.sync_info(roles, networks)


# Retrieving subnets
subnet = networks["my_subnet"][0]
logging.info(subnet)

n_vms = 10

virt_conf = (
    en.VMonG5kConf.from_settings(image="/grid5000/virt-images/debian11-x64-base.qcow2")
    .add_machine(
        roles=["cp"],
        number=1,
        undercloud=roles["role1"],
        macs=list(subnet.free_macs)[0:1],
        flavour_desc={"core": 2, "mem": 8192}
    )
    .add_machine(
        roles=["vms"],
        number=n_vms,
        undercloud=roles["role1"],
        macs=list(subnet.free_macs)[1:n_vms+1],
        flavour_desc={"core": 1, "mem": 4096}
    )
    .finalize()
)

vmroles = en.start_virtualmachines(virt_conf)

print(vmroles)

print(networks)

