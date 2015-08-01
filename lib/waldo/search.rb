require 'waldo/scanner'
require 'waldo/dsl'
require 'waldo/scope'

module Waldo
  class Search < SimpleDelegator
    extend Waldo::DSL

    attr_reader :scopes

    def initialize(query)
      @query = query.to_s
      @scopes = self.class.scopes
      @scanned_scopes = Scanner.scan(@query, scopes_names)
      @ar_relation = self.class.model_klass
      exec_scopes
      __setobj__(@ar_relation)
    end

    def scopes_names
      @scopes.map { |s| s.name }.uniq
    end

    private
    def exec_scopes
      @ar_relation = @scanned_scopes.reduce(@ar_relation) do |model, (scope, value)|
        @scopes.select { |s| s.name == scope }.reduce(model) do |m, s|
          s.call(value, m)
        end
      end
    end
  end
end
