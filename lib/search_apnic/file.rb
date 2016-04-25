require 'net/http'
module SearchApnic
  class File
    def head
      HOST = 'ftp.apnic.net'
      PATH = '/stats/apnic/delegated-apnic-latest'
      # IPADDR_URL = 'http://ftp.apnic.net/stats/apnic/delegated-apnic-latest'

      url = URI(HOST)

      Net::HTTP.start(url.host, url.port){|http|
        response = http.head(PATH)
        puts response
      }
    end
  end
end
