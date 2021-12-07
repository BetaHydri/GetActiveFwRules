# GetActiveFwRules
Description: Get all Windows Firewall rules that are active due to the actual active network connection profiles

---
## Sample usage:
_$out = (Get-ActiveFirewallRules)_

_$out  | Out-GridView -Title "Total active Windows Firewall rules: $($out.count) / From active profiles: $($Global:ActiveProfiles -join ",")"_


Name                                                 |Direction    |Profiles         | Action| Protocol|  LocalPort       | RemotePort | RemoteAddress
:----                                                |:---------   |:--------        | :-----| :-------|  :---------      | :--------- | :-------------
Windows Media Player (UDP-In)                        |    Inbound  |             Any |  Allow| UDP     |  Any             | Any        | Any
Windows Media Player x86 (UDP-In)                    |    Inbound  |             Any |  Allow| UDP     |  Any             | Any        | Any
OpenSSH SSH Server (sshd)                            |    Inbound  |             Any |  Allow| TCP     |  22              | Any        | Any
DFS Management (WMI-In)                              |    Inbound  |             Any |  Allow| TCP     |  RPC             | Any        | Any
DFS Management (SMB-In)                              |    Inbound  |             Any |  Allow| TCP     |  445             | Any        | Any
DFS Management (DCOM-In)                             |    Inbound  |             Any |  Allow| TCP     |  135             | Any        | Any
DFS Management (TCP-In)                              |    Inbound  |             Any |  Allow| TCP     |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP6-ER-In)         |    Inbound  |             Any |  Allow| ICMPv6  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP6-DU-In)         |    Inbound  |             Any |  Allow| ICMPv6  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP6-ERQ-Out)       |   Outbound  |             Any |  Allow| ICMPv6  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP4-ERQ-Out)       |   Outbound  |             Any |  Allow| ICMPv4  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP4-ER-In)         |    Inbound  |             Any |  Allow| ICMPv4  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP4-DU-In)         |    Inbound  |             Any |  Allow| ICMPv4  |  RPC             | Any        | Any
DFS Management (TCP-In)                              |    Inbound  |             Any |  Allow| TCP     |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP6-ER-In)         |    Inbound  |             Any |  Allow| ICMPv6  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP6-DU-In)         |    Inbound  |             Any |  Allow| ICMPv6  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP6-ERQ-Out)       |   Outbound  |             Any |  Allow| ICMPv6  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP4-ERQ-Out)       |   Outbound  |             Any |  Allow| ICMPv4  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP4-ER-In)         |    Inbound  |             Any |  Allow| ICMPv4  |  RPC             | Any        | Any
Network Load Balancing Manager (ICMP4-DU-In)         |    Inbound  |             Any |  Allow| ICMPv4  |  RPC             | Any        | Any
Cast to Device streaming server (HTTP-Streaming-In)  |    Inbound  |          Domain |  Allow| TCP     |  10246           | Any        | Any
Cast to Device UPnP Events (TCP-In)                  |    Inbound  |          Public |  Allow| TCP     |  2869            | Any        | PlayToDevice
Cast to Device SSDP Discovery (UDP-In)               |    Inbound  |          Public |  Allow| UDP     |  PlayToDiscovery | Any        | Any
Cast to Device functionality (qWave-TCP-In)          |    Inbound  | Private, Public |  Allow| TCP     |  2177            | Any        | PlayToDevice
Cast to Device functionality (qWave-UDP-Out)         |   Outbound  | Private, Public |  Allow| UDP     |  Any             | 2177       | PlayToDevice
Cloud Identity (TCP-Out)                             |   Outbound  |             Any |  Allow| TCP     |  Any             | 443        | Any
Cast to Device functionality (qWave-UDP-In)          |    Inbound  | Private, Public |  Allow| UDP     |  2177            | Any        | PlayToDevice
Cast to Device streaming server (RTP-Streaming-Out)  |   Outbound  |          Public |  Allow| UDP     |  Any             | Any        | PlayToDevice
Cast to Device functionality (qWave-TCP-Out)         |   Outbound  | Private, Public |  Allow| TCP     |  Any             | 2177       | PlayToDevice