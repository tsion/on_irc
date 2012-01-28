class IRC
  module Parser  
    def self.parse(line)      
      prefix = ''
      command = ''
      params = []
      msg = StringScanner.new(line.unpack('C*').pack('U*'))
      
      if msg.peek(1) == ':'
        msg.pos += 1
        prefix = msg.scan /\S+/u
        msg.skip /\s+/
      end
      
      command = msg.scan /\S+/u
      
      until msg.eos?
        msg.skip /\s+/
        
        if msg.peek(1) == ':'
          msg.pos += 1
          params << msg.rest
          msg.terminate
        else
          params << msg.scan(/\S+/u)
        end
      end
      
      {:prefix => prefix, :command => command, :params => params}
    end
  end
end

