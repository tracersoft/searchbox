require 'spec_helper'

describe Searchbox::Relation do
  let(:ar_relation) { spy('ar relation', all: double, find: 1) }
  let(:relation) { Searchbox::Relation.new(ar_relation) }

  describe '#method_missing' do
    it 'delegates to ar relation' do
      relation.method_missing(:all)
      expect(ar_relation).to have_received(:all)
    end

    it 'returns a new search relation' do
      ret = relation.method_missing(:all)
      expect(ret).to be_kind_of(relation.class)
    end

    context 'method is really missing' do
      it 'raises an error' do
        expect(ar_relation).to receive(:respond_to?).with(:abcdef) { false }
        expect { relation.abcdef }.to raise_error(NoMethodError)
      end
    end

    context 'when delegated, the return is not the same type as the ar_relation' do
      it 'returns the returned type from delegation' do
        ret = relation.method_missing(:find)
        expect(ret).to be(ar_relation.find)
      end
    end
  end

  describe '#respond_to?' do
    it 'delegates to the ar relation' do
      relation.respond_to?(:abcdef)
      expect(ar_relation).to have_received(:respond_to?).with(:abcdef)
    end
  end
end
