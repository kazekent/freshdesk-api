require 'freshdesk'
# require 'freshdesk/api/codes'

class Freshdesk

  class Client
    def self.for_company(company, api_key)
      self.new(company: company, api_key: api_key)
    end

    attr_reader :client

    def initialize(options = {})
      @api_url = options[:api_url] 
      @username = options[:username]
      @password = options[:password]
      if options[:company]
        @company = options[:company]
        @api_key = options[:api_key]
        @api_url  ||= "http://#{@company}.freshdesk.com/"
        @username ||= options[:api_key]
        @password ||= 'X'        
      else
        raise ArgumentError.new("Missing arguments for #{self.class} constructor.") unless @api_url && @username && @password
      end
      @client = ::Freshdesk.new(@api_url, @username, @password)
      @client.response_format = 'json'
    end

    def tickets(options = {})
      options[:filter_name] ||= options.delete(:filter) || :all_tickets
      @tickets = []
      page_num = (options[:page]||1).to_i
      begin
        options[:page] = page_num
        found = fetch_json_response(:get_tickets, options)
        puts "* Found #{found.size} tickets... (page #{page_num})"
        @tickets += found
        page_num += 1
      end while found && found.size > 0 && page_num < 100
      @tickets
    end

    def companies(options = {})
      @companies = fetch_json_response(:get_companies, options)
    end

    def fetch_json_response(target, options = {})
      str = @client.send(target, options)
      JSON.parse(str)
    end

  end

end