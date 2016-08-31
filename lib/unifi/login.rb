module Unifi
  class Login < PostToController
    include Troupe

    expects :username
    expects :password

    provides(:url) { '/api/login' }

    provides :json do
      {
        login: 'login',
        username: username,
        password: password
      }.to_json
    end
  end
end