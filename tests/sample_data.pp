$vcenter = {
  'username' => 'root',
  'password' => 'vmware',
  'server'   => '192.168.1.1',
  'options'  => { 'insecure' => true }
}

$vshield= {
  'username' => 'admin',
  'password' => 'default',
  'server'   => '192.168.1.2',
}

$dc1 = {
  'name' => 'testdc',
  'path' => '/testdc',
}

$cluster1 = {
  'name' => 'clu1',
}

$esx1 = {
  'username' => 'root',
  'password' => 'password',
  'hostname' => '192.168.1.100',
}

$edge = {
  'name' => 'dmz',
  'fqdn' => 'dmz.edge.lan',
  'vnics' => [
    { name          => 'uplink-test',
      portgroupName => 'd5p0pod-cus-pg-14',
      type          => 'uplink',
      isConnected   => true,
      addressGroups => {
        'addressGroup' => {
          'primaryAddress' => '69.194.136.20',
          'secondaryAddresses' => {
            'ipAddress' => [ '69.194.136.21', '69.194.136.22' ],
          },
          'subnetMask' => '255.255.255.128',
        },
      },
    },
    { name          =>'internal-1',
      portgroupName => 'd5p0v1-dmz-pg-60',
      type          => 'internal',
      isConnected   => true,
      addressGroups => {
        'addressGroup' => {
          'primaryAddress' => '10.10.0.20',
          'secondaryAddresses' => {
            'ipAddress' => [ '10.10.0.21', '10.10.0.22' ],
          },
          'subnetMask' => '255.255.255.192',
        },
      },
    },
  ],
  ha => {
         ip_addresses    => [ '192.168.0.1', '192.168.0.2' ],
         vnic            => 1,
         datastore_name  => [ 'ns120-lun1', 'ns120-lun2' ],
  }
}

$default_route = { gatewayAddress => '69.194.136.1', vnic => 'uplink-test' },
$static_routes = [
  { network => '10.0.32.0/24', nextHop => '10.10.0.1', vnic => 'internal-1' },
]

$dhcp_pools = [
  {
    ipRange             => '192.168.5.70-192.168.5.75',
    defaultGateway      => '192.168.5.145',
    domainName          => 'eng.vmware.com',
    primaryNameServer   => '192.168.5.1',
    secondaryNameServer => '8.8.8.8',
    leaseTime           => 3600,
    autoConfigureDNS    => false,
  },
  {
    ipRange             => '192.168.5.30-192.168.5.39',
    defaultGateway      => '192.168.5.145',
    domainName          => 'eng.vmware.com',
    primaryNameServer   => '192.168.5.1',
    secondaryNameServer => '8.8.8.8',
    leaseTime           => 3600,
    autoConfigureDNS    => false,
  },
]

$dhcp_bindings = [
  { vnicId              => 1,
    hostname            => 'dhcp-test',
    ipAddress           => '192.168.5.47',
    defaultGateway      => '192.168.5.145',
    domainName          => 'eng.vmware.com',
    primaryNameServer   => '8.8.8.8',
    secondaryNameServer => '8.8.4.4',
    leaseTime           => 3600,
    autoConfigureDNS    => false,
  },
]

$dhcp_logging = {
  enable    => false,
  logLevel  => 'info'
}

$dhcp_enabled = false



$nat1 = {
  action => dnat,
  vnic   => 1,
  original_address => '10.10.0.1',
  translated_address => '192.168.0.1',
}

$nat2 = {
  action => dnat,
  vnic   => 1,
  original_address => '10.10.0.2',
  translated_address => '192.168.0.2',
}

$vxlan_switch1 = {
  switch => { name => 'dvSwitch' },
  teaming => 'LACP_PASSIVE',
  mtu     => 1600,
}

$vxlan_map1 = {
  switch => { name => 'dvSwitch' },
  vlan_id  => 0,
}

$vxlan_segment1 = {
  id    => '1',
  name  => 'segment1',
  desc  => 'test segment 1',
  begin => 6000,
  end   => 8000,
}

$vxlan_multicast1 = {
  id    => '1',
  name  => 'multicast1',
  desc  => 'test multicast 1',
  begin => '239.1.1.1',
  end   => '239.3.3.3',
}

$vxlan_scope1 = {
  name  => 'vLab',
  description => 'test scope 1',
  clusters => {
    cluster => {
      cluster => {},
    },
  },
}

$vxlan1 = {
  name        => 'vWire1',
  description => 'virtual wire 1',
  tenant_id   => 'production',
}

$vxlan_udp_port = 8479

