require 'spec_helper'

RSpec.describe 'Occurrence' do
  let(:monitor_id) { 12345 }
  let!(:occurrence) { Seekr::Occurrence.new(monitor_id) }

  describe '#all' do

    it_behaves_like "API authentication required" do
      let(:request) { occurrence.all }
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
        let!(:response) { JSON.parse(occurrence.all) }

        it { expect(response['search_results'].size).to eq 100 }
      end

      context 'with filter by tag' do
        let!(:response) { JSON.parse(occurrence.all(tag: [1])) }

        it { expect(response['search_results'].size).to eq 1 }
        it { expect(response['search_results'][0]['id']).to eq 9999 }
        it { expect(response['search_results'][0]['url']).to eq "http://example.com/user/statuses/9999999999" }
      end
    end
  end

  describe '#all_paginated' do

    it_behaves_like "API authentication required" do
      let(:request) { occurrence.all_paginated }
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
        let!(:response) { JSON.parse(occurrence.all_paginated) }

        it { expect(response['search_results'].size).to eq 102 }
      end

      context 'with filter by tag' do
        let!(:response) { JSON.parse(occurrence.all_paginated(tag: [1])) }

        it { expect(response['search_results'].size).to eq 1 }
        it { expect(response['search_results'][0]['id']).to eq 9999 }
        it { expect(response['search_results'][0]['url']).to eq "http://example.com/user/statuses/9999999999" }
      end
    end
  end
end
