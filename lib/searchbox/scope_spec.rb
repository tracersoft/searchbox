require 'spec_helper'

describe Searchbox::Scope do
  let(:scope) { Searchbox::Scope.new(:scope) }
  let(:relation) { spy }
  let(:value) { 'value' }

  describe '#call' do
    context 'relation dont respond to scope methods' do
      let(:relation) { double }
      it 'returns the relation' do
        expect(scope.call(value, relation)).to eq(relation)
      end
    end

    it 'sets the scope value' do
      scope.call(value, relation)
      expect(scope.value).to eq(value)
    end

    context 'has block' do
      let(:scope) { Searchbox::Scope.new(:scope,
                                         -> (v) { expected_to_be_called(v) }) }

      it 'executes block in relation instance' do
        scope.call(value, relation)
        expect(relation).to have_received(:expected_to_be_called).with(value)
      end
    end

    context 'pass the method name' do
      let(:scope) { Searchbox::Scope.new(:scope, :expected_to_be_called) }

      it 'executes block in relation instance' do
        scope.call(value, relation)
        expect(relation).to have_received(:expected_to_be_called).with(value)
      end
    end

    context 'execute the scope name' do
      let(:scope) { Searchbox::Scope.new(:scope) }

      it 'executes block in relation instance' do
        scope.call(value, relation)
        expect(relation).to have_received(:scope).with(value)
      end
    end
  end

  describe Searchbox::BoolScope do
    let(:criteria) { :criteria }
    let(:scope) { Searchbox::BoolScope.new(:scope, criteria) }

    describe '#call' do
      context 'relation dont respond to scope methods' do
        let(:relation) { double }
        it 'returns the relation' do
          expect(scope.call(value, relation)).to eq(relation)
        end
      end

      context 'criteria not matches' do
        it 'returns the relation' do
          expect(scope.call(value, relation)).to eq(relation)
        end

        it 'sets the scope a falsy' do
          scope.call(value, relation)
          expect(scope.value).to be false
        end
      end

      context 'criteria matches' do
        it 'sets the scope as truthy' do
          scope.call(criteria, relation)
          expect(scope.value).to be true
        end

        context 'has block' do
          let(:scope) { Searchbox::BoolScope.new(:scope, criteria,
                                            -> () { expected_to_be_called }) }

          it 'executes block in relation instance' do
            scope.call(criteria, relation)
            expect(relation).to have_received(:expected_to_be_called)
          end
        end

        context 'execute the scope name' do
          let(:scope) { Searchbox::BoolScope.new(:scope, criteria) }

          it 'executes block in relation instance' do
            scope.call(criteria, relation)
            expect(relation).to have_received(criteria)
          end
        end

        context 'pass the method name' do
          let(:scope) { Searchbox::BoolScope.new(:scope, criteria,
                                                 :expected_to_be_called) }

          it 'executes block in relation instance' do
            expect(relation).to receive(:respond_to?).with(criteria) { false }
            scope.call(criteria, relation)
            expect(relation).to have_received(:expected_to_be_called)
          end
        end

        context 'execute the scope name' do
          let(:scope) { Searchbox::BoolScope.new(:scope, criteria) }

          it 'executes block in relation instance' do
            expect(relation).to receive(:respond_to?).with(criteria) { false }
            scope.call(criteria, relation)
            expect(relation).to have_received(:scope).with(criteria)
          end
        end
      end
    end
  end
end
