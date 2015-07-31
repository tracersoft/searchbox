require 'spec_helper'

describe Waldo::Search do
  let(:model_klass) { spy("Model", expected_to_be_called: true) }
  let(:query) { "test: Teste" }
  let(:search) { DummyWaldoSearch.new(query) }

  class DummyWaldoSearch < Waldo::Search
    scope :test, -> (arg) {
      expected_to_be_called(arg)
      self
    }
  end

  before do
    DummyWaldoSearch.model model_klass
  end

  describe '#to_a' do
    it 'executes the corrects scopes' do
      search.to_a
      expect(model_klass).to have_received(:expected_to_be_called).with("Teste")
    end
  end
end
