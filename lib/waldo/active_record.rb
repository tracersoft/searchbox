module Waldo
  module ActiveRecordDSL
    def fields(*fields)
      fields.each do |f|
        scope f, -> (v) {
          where(f=>v)
        }
      end
    end
  end

  class Search
    extend ActiveRecordDSL
  end
end
