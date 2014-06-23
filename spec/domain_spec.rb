require 'spec_helper'

describe UnobtrusiveFlash::ControllerMixin do
  describe '#unobtrusive_flash_domain' do
    let(:controller_class) { Struct.new(:request) }
    before(:each) { controller_class.send(:include, UnobtrusiveFlash::ControllerMixin) }
    subject { controller_class.new( double('request', host: host) ) }

    context 'not on Heroku' do
      let(:host) { 'microsoft.com' }

      it 'should use :all' do
        expect(subject.send(:unobtrusive_flash_domain)).to eq(:all)
      end
    end

    context 'on Heroku' do
      let(:host) { 'myapp.herokuapp.com' }

      it 'should use the host' do
        expect(subject.send(:unobtrusive_flash_domain)).to eq('myapp.herokuapp.com')
      end
    end
  end
end