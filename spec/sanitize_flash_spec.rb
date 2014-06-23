require 'spec_helper'

describe UnobtrusiveFlash::ControllerMixin do
  describe '.sanitize_flash' do
    it 'should escape messages that are not html safe' do
      expect(described_class.sanitize_flash({:foo => '<bar>'})).to eq([[:foo, '&lt;bar&gt;']])
    end

    it 'should not escape messages that are html safe' do
      expect(described_class.sanitize_flash({:foo => '<bar>'.html_safe})).to eq([[:foo, '<bar>']])
    end
  end
end