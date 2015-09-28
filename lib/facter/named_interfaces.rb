# read value of named_interfaces fact
if Facter.value(:named_interfaces)
  hash = Facter.value(:named_interfaces)

  hash.each_pair do |key,array|
    hash[key].each.with_index(1) do |iface, index|
      # set up interface aliases for these facts
      facts = %w(ipaddress macaddress mtu netmask network)

      facts.each do |fact|
        Facter.add("#{fact}_#{key}#{index}") do
          confine { !Facter.value("#{fact}_#{iface}").nil? }
          setcode { Facter.value("#{fact}_#{iface}") }
        end
      end
    end
  end
end
