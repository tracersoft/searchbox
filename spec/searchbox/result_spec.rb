describe Searchbox::Relation do
  let(:ar_relation) { spy('ar relation', all: ar_relation) }
  let(:relation) { Searchbox::Relation.new(ar_relation) }

  describe '#method_missing?' do
    it 'delegates to model' do
      relation.method_missing(:all)
      expect(ar_relation).to have_received(:all)
    end

    it 'returns a new search relation' do
      ret = relation.method_missing(:all)
      expect(ret).to be_kind_of(relation.class)
    end

    context 'when delegated, the return is not the same type as the ar_relation' do
      it 'returns the returned type from delegation' do

      end
    end
  end
end
