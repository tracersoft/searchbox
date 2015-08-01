module Waldo
  module DSL
    attr_reader :scopes, :model_klass

    def scopes
      @scopes ||= []
    end

    def scope(name, block=nil)
      scopes << [name, block]
    end

    def model(model_klass)
      @model_klass = model_klass
    end

    #builtin scopes
    def has(value, block=nil)
      scope :has, -> (actual_value) {
        if value.to_s == actual_value.to_s
          if block.respond_to?(:call)
            self.instance_exec(&block)
          else
            self.send(value)
          end
        end
      }
    end

    alias_method :in, :has
    alias_method :is, :has
  end
end
