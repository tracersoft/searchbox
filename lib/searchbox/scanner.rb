module Searchbox
  class Scanner
    def self.scan(query, tokens)
      new(query, tokens).scan
    end

    def initialize(query, tokens)
      @scanner = StringScanner.new(query)
      @tokens = tokens
      @fulltext = []
    end

    def scan
      tokens = []
      tokens << scan_token until @scanner.eos?
      tokens << fulltext_token
      tokens.compact
    end

    private
    def scan_token
      scan_space
      scan_scope || scan_text
    end

    def tokens_regex
      %r{#{@tokens.map { |t| "#{t}:" }.join('|')}}
    end

    def scan_space
      @scanner.scan(/\s+/)
    end

    def scan_scope
      if token = @scanner.scan(tokens_regex)
        scan_space
        value = @scanner.scan_until(/"([^"]+)"|'([^']+)'|\S+/)
        if value
          value.gsub!(/"|'/, '')
          scan_space
          [token.tr(':', '').to_sym, value]
        end
      end
    end

    def fulltext_token
      unless @fulltext.empty?
        [:fulltext, @fulltext.join(' ')]
      end
    end

    def scan_text
      if value = @scanner.scan_until(/\S+/)
        scan_space
        unless value.empty?
          @fulltext << value
          nil
        end
      end
    end
  end
end
