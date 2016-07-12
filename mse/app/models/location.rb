require 'src/mse/CMX/API/Location'
class Location < ApplicationRecord

  def self.get_client_count
    res = CMX::API::Location.get_count
  end


  def self.get_ap_stats
    res      = CMX::API::Location.get_clients
    if res.nil? || res.empty?
      sleep(4)
      res    = CMX::API::Location.get_clients
    end
    aps      = {}
    result   = JSON.parse(res)
    result.each do |client|
      if not aps[client["apMacAddress"]] and client["apMacAddress"] != ""
        address = client["apMacAddress"]
        aps[address] = {
          "connectedDeviceCount": 1,
          "connectedDevices": [{
            "ip": client["ipAddress"],
            "ssId": client["ssId"],
            "mapCoordinate": client["MapCoordinate"]
          }]
        }
      end
      if aps[client["apMacAddress"]] and client["apMacAddress"] != ""
         address = client["apMacAddress"]
         aps[address][:connectedDeviceCount] += 1
         aps[address][:connectedDevices] << {
          "ip": client["ipAddress"],
          "ssId": client["ssId"],
          "mapCoordinate": client["mapCoordinate"]
         }
      end
    end
    sorted_hash = aps.sort_by { |k, v| aps[k][:connectedDeviceCount] }.reverse!
    first_ten   = sorted_hash.first(10)
    sorted_hash = {
      "results": first_ten
    }
  end

end
