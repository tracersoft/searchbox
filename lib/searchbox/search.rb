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
      @data = Hash.new

      @scanned_scopes.each do |param, value|
        @data[param] = value
      end

      scopes.select {|scope|
        if scope.name.class == Array          
          (@data.keys & scope.name).length == scope.name.length
        else
          @data.keys.index(scope.name)
        end
      }.reduce(@klass) do |klass, scope|        
        values = []
        if scope.name.class == Array          
          values = scope.name.map do |key|
            @data[key] 
          end
        else
          values << @data[scope.name]  
        end
        
        binding.pry
        scope.call(values, klass)
      end
    end
  end
end
