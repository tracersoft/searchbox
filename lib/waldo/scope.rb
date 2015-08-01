module Waldo
  class Scope
    attr_reader :name, :value

    def initialize(name, block=nil)
      @name = name
      @block = block
      @value = nil
    end

    def call(value, model)
      @value = value

      if @block.respond_to?(:call)
        model.instance_exec(value, &@block)
      elsif @block && model.respond_to?(@block)
        model.send(@block, value)
      elsif model.respond_to?(@name)
        model.send(@name, value)
      else
        model
      end
    end
  end

  class BoolScope < Scope
    attr_reader :criteria

    def initialize(name, criteria, block=nil)
      super(name, block)
      @criteria = criteria
    end

    def call(value, model)
      if value.to_s == @criteria.to_s
        @value = true
        if @block.respond_to?(:call)
          model.instance_exec(value, &@block)
        elsif model.respond_to?(@criteria)
          model.send(@criteria)
        elsif @block && model.respond_to?(@block)
          model.send(@block, value)
        else
          model
        end
      else
        model
      end
    end
  end
end
