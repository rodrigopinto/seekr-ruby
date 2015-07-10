require 'spec_helper'

RSpec.describe 'Configuration' do

  context 'when configured' do
    before(:all) do
      Seekr.configure do |config|
        config.api_key = "abcde"
        config.api_secret = "12345"
      end
    end

    after(:all) { Seekr.reset }

    it { expect(Seekr.api_key).to eq "abcde" }
    it { expect(Seekr.api_secret).to eq "12345" }
  end

  context 'when not configured' do
    it { expect(Seekr.api_key).to be_nil }
    it { expect(Seekr.api_secret).to be_nil }
  end
end
