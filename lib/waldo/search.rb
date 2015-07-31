require 'waldo/scanner'
require 'waldo/dsl'

module Waldo
  class Search < SimpleDelegator
    extend Waldo::DSL

    def initialize(query)
      @query = query
      @scanned_scopes = Scanner.scan(query, self.class.scopes.keys)
      @scopes = self.class.scopes
      @ar_relation = self.class.model_klass
      exec_scopes
      __setobj__(@ar_relation)
    end

    private
    def exec_scopes
      @ar_relation = @scanned_scopes.reduce(@ar_relation) do |model, (scope, value)|
        scope_block = @scopes[scope]
        if scope_block.respond_to?(:call)
          model.instance_exec(value, &scope_block)
        else
          model.send(scope, value)
        end
      end
    end
  end
end

