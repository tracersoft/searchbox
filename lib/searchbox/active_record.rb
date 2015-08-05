module Searchbox
  module ActiveRecord
    module DSL
      def fields(*fields)
        fields.each do |f|
          scope f, -> (v) {
            where(f=>v)
          }
        end
      end
    end
  end

  class Search < Relation
    extend ActiveRecord::DSL
  end
end
