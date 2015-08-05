module Searchbox
  module DSL
    attr_reader :klass

    def scopes
      @scopes ||= [Scope.new(:fulltext)]
    end

    def klass(klass)
      @klass = klass
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

    module InstanceMethods
      def klass
        self.class.klass
      end

      def scopes
        self.class.scopes
      end

      def scope_options
        scopes.map(&:name).uniq
      end
    end
  end
end
