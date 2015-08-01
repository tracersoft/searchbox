require 'waldo/scanner'
require 'waldo/dsl'

module Waldo
  class Search < SimpleDelegator
    extend Waldo::DSL

    def initialize(query)
      @query = query
      @scopes = self.class.scopes
      @scanned_scopes = Scanner.scan(query, possible_scopes)
      @ar_relation = self.class.model_klass
      exec_scopes
      __setobj__(@ar_relation)
    end

    private
    def exec_scopes
      @ar_relation = @scanned_scopes.reduce(@ar_relation) do |model, (scope, value)|
        @scopes.select { |s| s.first == scope }.each do |(s, b)|
          if b.respond_to?(:call)
            model.instance_exec(value, &b)
          elsif model.respond_to?(s)
            model.send(s, value)
          end
        end
      end
    end

    def possible_scopes
      @scopes.map { |s| s.first }.uniq
    end
  end
end

