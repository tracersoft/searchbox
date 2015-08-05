module Searchbox
  class Relation
    attr_reader :relation, :scopes

    def initialize(relation, scopes)
      @relation = relation
      @scopes = scopes
    end

    def method_missing(method, *args, &block)
      if @relation.respond_to?(method)
        ret = @relation.send(method, *args, &block)
        if ret.kind_of?(@relation.class)
          Relation.new(ret, @scopes)
        else
          ret
        end
      else
        raise NoMethodError.new("Undefined method #{method} in #{@relation.class}", method, *args)
      end
    end

    def respond_to?(*args)
      @relation.respond_to?(*args)
    end
  end
end
