require 'ipaddr'
module SearchApnic
  class Search

    # File Format http://ftp.apnic.net/apnic/stats/apnic/README.TXT
    def by_country(country, protocol_version: 'ipv4')
      ::File.foreach(SearchApnic::File.new.get_path) do |l|
        next if l[0] == "#" # Comment Line

        row = l.strip.split("|")

        unless header
          set_header(row)
          next
        end

        if(row[5] == 'summary')
          add_summary(row)
          next
        end

        record = parse_record(row)
        next if record[:type] == 'asn' # Autonomous System number
        next if record[:cc] != country
        next if record[:type] != protocol_version # ipv4 or ipv6
        add_record record
      end
      self
    end

    def print
      records.each do|l|
        puts l
      end
    end

    def include?(ip)
      search_first_number = ip.split(".").first
      records.select{|ip_and_mask| search_first_number == ip_and_mask.split(".").first}.each do |ip_and_mask|
        if IPAddr.new(ip_and_mask).include? ip
          return ip_and_mask
        end
      end
      return false
    end

    def self.countries
      %w{
        AP AS AU BD BN BR BT
        CA CK CN CO
        DE
        ES
        FJ FM FR
        GB GU
        HK
        ID IN IO IR
        JP
        KE KH KI KP KR
        LA LK
        MH MM MN MO MP MU MV MY
        NC NF NL NP NR NU NZ
        PF PG PH PK PW
        SA SB SC SE SG
        TH TK TL TO TR TV TW
        US
        VN VU
        WF WS
        ZA
      }
    end

    def records
      @records
    end

    def summary
      @summary
    end

    def header
      @header
    end

    private

      def add_record(record)
        @records ||= []
        number_of_ip = record[:value].to_i
        start = record[:start]
        mask = 32 - ("%b" % number_of_ip).length + 1
        ip = "#{start}/#{mask}"

        @records << ip
      end

      def parse_record(row)
        {
          registry: row.shift,
          cc: row.shift,
          type: row.shift,
          start: row.shift,
          value: row.shift,
          date: row.shift,
          status: row.shift,
          extensions: row
        }
      end

      def add_summary(row)
        @summary ||= []
        @summary << {
          registry: row.shift,
          noop1:    row.shift,
          type:     row.shift,
          noop2:    row.shift,
          count:    row.shift,
          summary:  row.shift,
        }
      end

      def set_header(row)
        @header = {
          version: row.shift,
          registry: row.shift,
          serial: row.shift,
          records: row.shift,
          startdate: row.shift,
          enddate: row.shift,
          utcoffset: row.shift
        }
      end
  end
end
