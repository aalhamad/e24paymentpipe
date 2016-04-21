require "rexml/document"
include REXML

module E24PaymentPipe
  
  # Parser support for income and outcome data.
  
  class Parser
    
    # Parsing secure data in xml. The data is stored in hash.
    # - <tt>:id</tt>          - Get the id found in the xml data
    # - <tt>:password</tt>    - Get the password
    # - <tt>:passwordhash</tt>- Get the password hash
    # - <tt>:web_address</tt> - Get the web address to perform transaction with.
    # - <tt>:port</tt>        - Get the port
    # - <tt>:context</tt>     - Get the context
    
    def self.parse_settings(data)
      raise ParserError, "Empty secure data" if data.empty?
      results = {}
      doc = REXML::Document.new(data).root
      results[:id ]          = doc.elements["id"].text
      results[:password]     = doc.elements["password"].text
      results[:passwordhash] = doc.elements["passwordhash"].text
      results[:web_address]  = doc.elements["webaddress"].text
      results[:port]         = doc.elements["port"].text
      results[:context]      = doc.elements["context"].text
      results
    end
  end
end
