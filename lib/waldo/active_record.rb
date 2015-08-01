module Waldo
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

  class Search
    extend ActiveRecord::DSL
  end
end
