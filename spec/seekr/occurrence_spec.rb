require 'spec_helper'

RSpec.describe 'Occurrence' do
  let(:monitor_id) { 12345 }
  let!(:occurrence) { Seekr::Occurrence.new }

  describe '#find_for' do

    it_behaves_like "API authentication required" do
      let(:request) { occurrence.find_for(monitor_id) }
    end

    context 'when API is authenticated' do
      before(:all) do
        Seekr.configure do |config|
          config.api_key = "apikey"
          config.api_secret = "secret"
        end
      end

      after(:all) do
        Seekr.reset
      end

      context 'without any filter' do
        let!(:response) { JSON.parse(occurrence.find_for(monitor_id)) }

        it { expect(response['search_results'].size).to eq 2 }
        it { expect(response['search_results'][0]['id']).to eq 9999 }
        it { expect(response['search_results'][0]['url']).to eq "http://example.com/user/statuses/9999999999" }
      end

      context 'with filter by tag' do
        let!(:response) { JSON.parse(occurrence.find_for(monitor_id, tag: [1])) }

        it { expect(response['search_results'].size).to eq 2 }
        it { expect(response['search_results'][0]['id']).to eq 9999 }
        it { expect(response['search_results'][0]['url']).to eq "http://example.com/user/statuses/9999999999" }
      end
    end
  end
end
