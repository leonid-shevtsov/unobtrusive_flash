require 'spec_helper'

describe UnobtrusiveFlash::ControllerMixin do
  describe '.sanitize_flash' do
    it 'should escape messages that are not html safe' do
      expect(described_class.sanitize_flash({:notice => '<bar>'}, [:notice])).to eq([["notice", '&lt;bar&gt;']])
    end

    it 'should not escape messages that are html safe' do
      expect(described_class.sanitize_flash({:notice => '<bar>'.html_safe}, [:notice])).to eq([["notice", '<bar>']])
    end

    it 'should remove messages that are not whitelisted to be displayed' do
      expect(described_class.sanitize_flash({:timedout => true}, [:notice])).to eq([])
    end
  end

  describe '.append_flash_to_cookie' do
    it 'should create a cookie if there is none' do
      expect(described_class.append_flash_to_cookie(nil, {:baz => 'qux'}, [:baz])).to eq('[["baz","qux"]]')
    end

    it 'should reuse existing cookie' do
      expect(described_class.append_flash_to_cookie('[["foo","bar"]]', {:baz => 'qux'}, [:baz])).to eq('[["foo","bar"],["baz","qux"]]')
    end

    it 'should not insert flash is already in the cookie' do
      expect(described_class.append_flash_to_cookie('[["foo","bar"]]', {:foo => 'bar'}, [:foo])).to eq('[["foo","bar"]]')
    end
  end
end
