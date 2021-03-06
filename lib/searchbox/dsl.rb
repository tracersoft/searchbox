module Searchbox
  module DSL
    def scopes
      @scopes ||= [Scope.new(:fulltext)]
    end

    def klass(klass=nil)
      if klass
        @klass = klass
      else
        @klass
      end
    end
    alias_method :model, :klass
    alias_method :base, :klass

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
        @klass ||= self.class.klass.dup
      end

      def scopes
        @scopes ||= self.class.scopes.map(&:dup)
      end

      def scope_options
        scopes.map(&:name).uniq
      end
    end
  end
end
