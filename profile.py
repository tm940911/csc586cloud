import geni.portal as portal
import geni.rspec.pg as pg
import geni.rspec.igext as IG

pc = portal.Context()
request = pc.makeRequestRSpec()

tourDescription = "Assignment 2"
tour = IG.Tour()
tour.Description(IG.Tour.TEXT,tourDescription)
request.addTour(tour)
prefixForIP = "192.168.1."
link = request.LAN("lan")

for i in range(2):
  if i == 0:
    node = request.XenVM("webserver")
    node.routable_control_ip = "true"
    node.addService(rspec.Execute(shell="/bin/sh", command="sudo mkdir -p /var/webserver_log"))
 else:
    node = request.XenVM("observer")
    node.routable_control_ip = "false"
    node.addService(rspec.Execute(shell="/bin/sh", command="sudo mkdir -p /var/webserver_monitor"))
  node.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU18-64-STD"
  iface = node.addInterface("if" + str(i))
  iface.component_id = "eth1"
  iface.addAddress(pg.IPv4Address(prefixForIP + str(i + 1), "255.255.255.0"))
  link.addInterface(iface)  
# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
