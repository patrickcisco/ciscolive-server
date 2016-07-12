
class LocationController < ApplicationController
 skip_before_filter  :verify_authenticity_token
  def ap_stats
    if params["token"] != "2alkdjf9k3rdjfasdfn"
      render :json => "{'msg': 'invalid'}", :status => :unauthorized
    else 
      hash = Location.get_ap_stats
      render :json => hash, :status => 200
    end
  end

  def client_count
    if params["token"] != "2alkdjf9k3rdjfasdfn"
      render :json => "{'msg': 'invalid'}", :status => :unauthorized
    else
      hash = Location.get_client_count
      render :json => hash, :status => 200
    end
  end

end
