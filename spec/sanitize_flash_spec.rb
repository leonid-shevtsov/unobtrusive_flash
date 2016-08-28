require 'spec_helper'

describe UnobtrusiveFlash::ControllerMixin do
  describe '.sanitize_flash' do
    it 'should escape messages that are not html safe' do
      expect(described_class.sanitize_flash({:notice => '<bar>'}, [:notice])).to eq([[:notice, '&lt;bar&gt;']])
    end

    it 'should not escape messages that are html safe' do
      expect(described_class.sanitize_flash({:notice => '<bar>'.html_safe}, [:notice])).to eq([[:notice, '<bar>']])
    end

    it 'should remove messages that are not whitelisted to be displayed' do
      expect(described_class.sanitize_flash({:timedout => true}, [:notice])).to eq([])
    end
  end
end
