require 'spec_helper'

describe Waldo::DSL do
  describe '#is' do
    it 'builds a scope' do
      klass = Class.new do
        extend Waldo::DSL
        is :expected_to_be_called, -> {}
      end

      expect(klass.scopes[0]).to be_kind_of(Waldo::BoolScope)
    end
  end
end
