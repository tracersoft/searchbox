require 'spec_helper'

describe Searchbox::DSL do
  describe '#is' do
    it 'builds a scope' do
      klass = Class.new do
        extend Searchbox::DSL
        is :expected_to_be_called, -> {}
      end

      expect(klass.scopes[0]).to be_kind_of(Searchbox::BoolScope)
    end
  end
end
