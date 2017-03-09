module Searchbox
  class Scope
    attr_reader :name, :value

    def initialize(name, block=nil)
      @name = name
      @block = block
      @value = nil
    end

    def call(value, relation)
      @value = value

      if @block.respond_to?(:call)
        relation.instance_exec(*value, &@block)
      elsif @block && relation.respond_to?(@block)
        relation.send(@block, *value)
      elsif relation.respond_to?(@name)
        relation.send(@name, *value)
      else
        relation
      end
    end
  end

  class BoolScope < Scope
    attr_reader :criteria

    def initialize(name, criteria, block=nil)
      super(name, block)
      @criteria = criteria
      @value = false
    end

    def call(value, relation)
      if value[0].to_s == @criteria.to_s
        @value = true
        if @block.respond_to?(:call)
          relation.instance_exec(&@block)
        elsif relation.respond_to?(@criteria)
          relation.send(@criteria)
        elsif @block && relation.respond_to?(@block)
          relation.send(@block)
        elsif relation.respond_to?(@name)
          relation.send(@name, value)
        else
          relation
        end
      else
        relation
      end
    end
  end
end
