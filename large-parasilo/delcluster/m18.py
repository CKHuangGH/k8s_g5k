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

name = "m18"

clusters = "parasilo"

site = "rennes"

en.init_logging(logging.INFO)

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
provider.destroy()