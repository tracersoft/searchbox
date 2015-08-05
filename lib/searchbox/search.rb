module Searchbox
  class Search < Relation
    extend Searchbox::DSL
    include Searchbox::DSL::InstanceMethods

    def initialize(query)
      @query = query.to_s
      @scanned_scopes = Scanner.scan(@query, scope_options)
      @klass = klass
      super(exec_scopes, scopes)
    end

    private
    def exec_scopes
      @scanned_scopes.reduce(@klass) do |klass, (scope, value)|
        scopes.select { |s| s.name == scope }.reduce(klass) do |k, s|
          s.call(value, k)
        end
      end
    end
  end
end
