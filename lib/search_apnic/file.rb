require 'net/http'
require 'open-uri'
require "awesome_print"
module SearchApnic
  class File
    HOST = 'ftp.apnic.net'
    PATH = '/stats/apnic/delegated-apnic-latest'
    CACHE_FILE = '/tmp/apnic-latest.txt'

    def get_path
      file = cache_file
      fresh?(file) ? file : get
    end

    def head
      Net::HTTP.new(HOST).head(PATH)
    end

    private

      def url
        "http://#{HOST}#{PATH}"
      end

      def get
        file = cache_file
        open(file, 'wb') do |file|
          open(url) do |data|
            file.write(data.read)
          end
        end
        file
      end

      def fresh?(file)
        ::FileTest.exist?(file) ? true : false
      end

      def cache_file
        "#{CACHE_FILE}.#{last_modified.to_i}"
      end

      def last_modified
        unless @last_modified
          @last_modified = Time.parse(head['last-modified'])
        end
        @last_modified
      end
  end
end
