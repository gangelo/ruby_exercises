require 'spec_helper'
require_relative '../caesar_cipher/caesar_cipher_service'

RSpec.describe CaesarCipherService do
  subject(:service) { described_class.new(string, shift) }

  let(:shift) { 0 }
  let(:string) { 'Hello World!' }

  describe 'initializer' do
    describe 'when valid parameters are passed' do
      it 'does not raise an error' do
        expect { service }.to_not raise_error
      end
    end

    describe 'when invalid parameters are passed' do
      context 'when a shift value is less than 0' do
        let(:shift) { -1 }

        it 'raises an error' do
          expect { service }.to raise_error ArgumentError
        end
      end

      context 'when a shift value is greater than the number of characters in the alphabet' do
        let(:shift) { described_class::CHARS.length }

        it 'raises an error' do
          expect { service }.to raise_error ArgumentError
        end
      end

      context 'when the string passed is nil' do
        let(:string) { nil }

        it 'raises an error' do
          expect { service }.to raise_error ArgumentError
        end
      end

      context 'when the string passed is empty?' do
        let(:string) { '' }

        it 'raises an error' do
          expect { service }.to raise_error ArgumentError
        end
      end

      it 'initializes the shift attribute' do
        expect(service.shift).to eq shift
      end

      it 'initializes the string attribute' do
        expect(service.string).to eq string
      end
    end
  end

  describe 'attributes' do
    let(:shift) { 2 }

    describe '#shift' do
      it 'responds to #shift' do
        expect(service).to respond_to :shift
      end
    end

    describe '#string' do
      it 'responds to #string' do
        expect(service).to respond_to :string
      end
    end
  end

  describe '#call' do
    context 'when shift is 0' do
      subject(:service) { described_class.new(string, shift).call }

      it 'returns string unaltered' do
        expect(service).to eq string
      end
    end

    context 'when shift is other than 0' do
      it 'returns the correct ciphered string' do
        expect(described_class.new('abcdefghijklmnopqrstuvwxyz', 1).call).to eq 'bcdefghijklmnopqrstuvwxyza'
        expect(described_class.new('abcdefghijklmnopqrstuvwxyz', 25).call).to eq 'zabcdefghijklmnopqrstuvwxy'
      end
    end

    context 'when passing a string with spaces' do
      it 'returns the correct ciphered string' do
        expect(described_class.new('What a string', 5).call).to eq 'Bmfy f xywnsl'
      end
    end

    context 'when passing a string with mixed case' do
      it 'returns the correct ciphered string' do
        expect(described_class.new('ComputeR', 7).call).to eq 'JvtwbalY'
      end
    end

    context 'when passing a string with non-alpha characters (excluding spaces)' do
      it 'returns the correct ciphered string' do
        expect(described_class.new('?Comp#uteR!', 7).call).to eq '?Jvtw#balY!'
      end
    end

    context 'when passing a string with spaces, mixed case and non-alpha characters' do
      it 'returns the correct ciphered string' do
        expect(described_class.new('?Comp # uteR!', 7).call).to eq '?Jvtw # balY!'
      end
    end
  end
end
