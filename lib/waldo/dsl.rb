module Waldo
  module DSL
    attr_reader :scopes, :model_klass

    def scopes
      @scopes ||= []
    end

    def model(model_klass)
      @model_klass = model_klass
    end

    def scope(name, block=nil)
      add_scope Scope.new(name, block)
    end

    #builtin scopes
    def has(criteria, block=nil)
      add_scope BoolScope.new(__callee__, criteria, block)
    end

    alias_method :in, :has
    alias_method :is, :has

    private
    def add_scope(scope)
      scopes << scope
    end
  end
end
