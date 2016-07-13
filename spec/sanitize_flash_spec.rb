require 'spec_helper'

describe UnobtrusiveFlash::ControllerMixin do
  describe '.sanitize_messages' do
    it 'should escape messages that are not html safe' do
      expect(described_class.sanitize_messages({:foo => '<bar>'})).to eq([[:foo, '&lt;bar&gt;']])
    end

    it 'should not escape messages that are html safe' do
      expect(described_class.sanitize_messages({:foo => '<bar>'.html_safe})).to eq([[:foo, '<bar>']])
    end
  end
end
