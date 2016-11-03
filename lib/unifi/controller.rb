module Unifi
  class Controller
    attr_reader :site, :uri

    def initialize(host:, port: 8443, site: 'default', verify_peer: true)
      @uri = Addressable::URI.new(host: host, port: port, scheme: 'https')
      @site = site
      @conn = Faraday.new(
        url: uri.to_s,
        ssl: { verify: verify_peer }
      ) do |faraday|
        faraday.use      :cookie_jar
        # faraday.response :logger
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter  Faraday.default_adapter
      end
    end

    def login(opts)
      interactor = Unifi::Login.call(opts.merge(conn: conn))
      interactor.response
    end

    def logout
      conn.post do |req|
        req.url '/api/logout'
      end
    end

    def stats(opts)
      interactor = Unifi::GetStat.call(opts.merge(site: site, conn: conn))
      interactor.response
    end

    def authorize_guest(opts)
      interactor = Unifi::AuthorizeGuest.call(opts.merge(site: site, conn: conn))
      interactor.response
    end

    def unauthorize_guest(opts)
      interactor = Unifi::UnauthorizeGuest.call(opts.merge(site: site, conn: conn))
      interactor.response
    end

    def clients
      interactor = Unifi::ListClients.call(site: site, conn: conn)
      interactor.response.body["data"]
    end

    def delete_voucher(opts)
      interactor = Unifi::DeleteVoucher.call(opts.merge(site: site, conn: conn))
      interactor.response
    end

    private
    attr_accessor :conn
  end
end
