require 'spec_helper'

describe UnobtrusiveFlash::ControllerMixin do
  describe '.sanitize_flash' do
    it 'should escape messages that are not html safe' do
      described_class.sanitize_flash({:foo => '<bar>'}).should == [[:foo, '&lt;bar&gt;']]
    end

    it 'should not escape messages that are html safe' do
      described_class.sanitize_flash({:foo => '<bar>'.html_safe}).should == [[:foo, '<bar>']]
    end
  end
end