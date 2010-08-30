class URLInformationExtractor
  def initialize(url)
    @url = url
  end
  
  def unwrap
    begin
      location = Net::HTTP.get_response(URI.parse(@url)).to_hash['location']
      location == nil ? @url : location[0]
    rescue
      @url
    end
  end
  
  def title
    begin
      agent = Mechanize.new
      agent.user_agent_alias = 'Mac Safari'
      agent.get(@url).title
    rescue Mechanize::ResponseCodeError
      @url
    end
  end
end