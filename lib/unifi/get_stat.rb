module Unifi
  class GetStat < PostToController
    include Troupe

    expects :site    # Controller site id
    expects :endpoint # Stat endpoint

    provides(:url) { "/api/s/#{site}/stat/#{endpoint}" }

    provides :json do
      {
          endpoint: endpoint,
      }.to_json
    end
  end
end