# Day 42: Create a Docker Network

## 🎯 task
The Nautilus DevOps team needs to set up several docker environments for different applications. One of the team members has been assigned a ticket where he has been asked to create some docker networks to be used later. Complete the task based on the following ticket description:

a. Create a docker network named as official on App Server 1 in Stratos DC.

b. Configure it to use macvlan drivers.

c. Set it to use subnet 172.28.0.0/24 and iprange 172.28.0.0/24.

## Solution
To create a Docker network named "official" using the macvlan driver with the specified subnet and IP range, you can use the following command on App Server 1 in Stratos DC:

```bash
docker network create -d macvlan --subnet=172.28.0.0/24 --ip-range=172.28.0.0/24 official
docker network ls
docker network inspect official
```
## other drivers
Docker supports several network drivers, including:
- bridge: The default network driver for containers on a single host.
- host: Removes network isolation between the container and the Docker host, allowing the container to use the host's network directly.
- overlay: Enables communication between containers across multiple Docker hosts, typically used in swarm mode.
- macvlan: Allows you to assign a MAC address to a container, making it appear as a physical device on the network. This is useful for scenarios where you want containers to have their own IP addresses on the local network.
- none: Disables all networking for the container, effectively isolating it from any network communication.
- ipvlan: Similar to macvlan, but it operates at the IP layer instead of the MAC layer, allowing for more efficient network communication in certain scenarios.
- transparent: A driver specific to Windows containers that allows them to connect directly to the physical network. Each driver has its own use cases and configurations, so it's important to choose the right one based on your specific requirements and network architecture.

