require 'spec_helper'

describe Waldo::Scanner do
  let(:tokens) { [:from, :name] }
  let(:query) { "from: joão@tracersoft.com.br name: João guaratinguetá" }
  let(:scanner) { Waldo::Scanner.new(query, tokens) }

  describe '#scan' do
    it 'returns the tokens with correct values' do
      expect(scanner.scan).to match_array([
        [:name, "João"],
        [:from, "joão@tracersoft.com.br"],
        [:fulltext, "guaratinguetá"]
      ])
    end
  end
end
