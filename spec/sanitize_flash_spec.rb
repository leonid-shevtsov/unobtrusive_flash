require 'spec_helper'

describe UnobtrusiveFlash::ControllerMixin do
  describe '.sanitize_flash' do
    it 'should escape messages that are not html safe' do
      expect(described_class.sanitize_flash({:notice => '<bar>'})).to eq([["notice", '&lt;bar&gt;']])
    end

    it 'should not escape messages that are html safe' do
      expect(described_class.sanitize_flash({:notice => '<bar>'.html_safe})).to eq([["notice", '<bar>']])
    end

    it 'should allow custom flash keys' do
      expect(described_class.sanitize_flash({'some.custom.key'.to_sym => "bar"})).to eq([["some.custom.key", "bar"]])
    end
  end

  describe '.append_flash_to_cookie' do
    it 'should create a cookie if there is none' do
      expect(described_class.append_flash_to_cookie(nil, {:baz => 'qux'})).to eq('[["baz","qux"]]')
    end

    it 'should reuse existing cookie' do
      expect(described_class.append_flash_to_cookie('[["foo","bar"]]', {:baz => 'qux'})).to eq('[["foo","bar"],["baz","qux"]]')
    end

    it 'should not insert flash is already in the cookie' do
      expect(described_class.append_flash_to_cookie('[["foo","bar"]]', {:foo => 'bar'})).to eq('[["foo","bar"]]')
    end

    it 'should reset cookie if it is null' do
      expect(described_class.append_flash_to_cookie('null', {:foo => 'bar'})).to eq('[["foo","bar"]]')
    end
  end
end
