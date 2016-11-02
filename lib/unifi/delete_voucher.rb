module Unifi
  class DeleteVoucher < PostToController
    include Troupe

    expects :site    # Controller site id
    expects :_id     # id of voucher to delete

    provides(:url) { "/api/s/#{site}/cmd/hotspot" }

    provides :json do
      {
        cmd: 'delete-voucher',
        _id: _id
      }.to_json
    end
  end
end