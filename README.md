```
[Steps]
Bring up kuneadm-dind
setup_tiller.sh, wait for tiller to be running in the cluster
install_service_catalog.sh - installs catalog from catalog-chart in this project
install_asb.sh - requires edits to point to a checkout of asb, installs asb but does
  specifically does not create the broker resource
create_asb_servicebroker.sh - Creates foo namespace, generates a ServiceBroker file with exported
  certs in .output, as well as a secret file to be copied into foo namespace.
  Creates ServiceBroker and auth secret in ns foo.

After running create_asb_servicebroker.sh, catalog should request /catalog
from the broker and create serviceclasses and serviceplans in foo namespace.
```
