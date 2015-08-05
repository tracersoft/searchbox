module Searchbox
  class Relation
    def initialize(relation)
      @relation = relation
    end

    def method_missing(method, *args, &block)
      if @relation.respond_to?(method)
        ret = @relation.send(method, *args, &block)
        if ret.kind_of?(@relation.class)
          Relation.new(ret)
        else
          ret
        end
      else
        raise NoMethodError
      end
    end

    def respond_to?(*args)
      @relation.respond_to?(*args)
    end
  end
end
