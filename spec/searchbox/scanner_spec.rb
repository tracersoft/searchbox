require 'spec_helper'

describe Searchbox::Scanner do
  let(:tokens) { [:from, :name] }
  let(:query) { "from: joão@tracersoft.com.br name: João guaratinguetá" }
  let(:scanner) { Searchbox::Scanner.new(query, tokens) }

  describe '#scan' do
    it 'returns the tokens with correct values' do
      expect(scanner.scan).to match_array([
        [:name, "João"],
        [:from, "joão@tracersoft.com.br"],
        [:fulltext, "guaratinguetá"]
      ])
    end

    context 'blank token value' do
      let(:query) {
        "from: "
      }

      it 'ignores the token' do
        expect(scanner.scan).to be_empty
      end
    end

    context 'the token value is enclosed with " or \'' do
      let(:query) {
        "from: joão@tracersoft.com.br name: 'João Futrica' guaratinguetá"
      }

      it 'returns the correc token value' do
        expect(scanner.scan).to include(
          [:name, "João Futrica"]
        )
      end
    end

    context 'full text composed value' do
      let(:query) {
        "from: joão@tracersoft.com.br name: 'João Futrica' são paulo"
      }

      it 'returns the correct token value' do
        expect(scanner.scan).to include(
          [:name, "João Futrica"],
          [:fulltext, "são paulo"]
        )
      end
    end

  end
end
