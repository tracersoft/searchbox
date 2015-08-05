require 'spec_helper'

describe Searchbox::Search do
  let(:model_klass) { spy("Model", expected_to_be_called: true) }
  let(:query) { "test: Teste" }
  let(:search_klass) {
    Class.new(Searchbox::Search) do
      klass model_klass
      scope :test, -> (arg) {
        expected_to_be_called(arg)
        self
      }
    end
  }
  let(:search) { search_klass.new(query) }

  it 'execute scopes' do
    search
    expect(model_klass).to have_received(:expected_to_be_called).with("Teste")
  end
end
