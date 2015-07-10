require 'spec_helper'
require 'pry'

RSpec.describe 'Monitor' do
  let!(:monitor) { Seekr::Monitor.new }

  describe '#all' do

    it_behaves_like "API authentication required" do
      let(:request) { monitor.all }
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

      let!(:response) { JSON.parse(monitor.all) }

      it {expect(response['searches'].size).to eq 2 }

      context 'first result' do
        it { expect(response['searches'][0]['id']).to eq 1 }
        it { expect(response['searches'][0]['name']).to eq "Monitor one" }
        it { expect(response['searches'][0]['search_results']).to eq 1243 }
        it { expect(response['searches'][0]['search_terms']).to eq 2 }
        it { expect(response['searches'][0]['tags']).to eq 7 }
        it { expect(response['searches'][0]['medias']).to eq 3 }
        it { expect(response['searches'][0]['active']).to be_truthy }
        it { expect(response['searches'][0]['sentiment_analysis']).to be_falsy }
      end

      context 'second result' do
        it { expect(response['searches'][1]['id']).to eq 2 }
        it { expect(response['searches'][1]['name']).to eq "Monitor 2" }
        it { expect(response['searches'][1]['search_results']).to eq 546 }
        it { expect(response['searches'][1]['search_terms']).to eq 5 }
        it { expect(response['searches'][1]['tags']).to eq 2 }
        it { expect(response['searches'][1]['medias']).to eq 0 }
        it { expect(response['searches'][1]['active']).to be_falsy }
        it { expect(response['searches'][1]['sentiment_analysis']).to be_falsy }
      end
    end
  end

  describe '#find' do
    it_behaves_like "API authentication required" do
      let(:request) { monitor.find(12345) }
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

      context 'when exists passed monitor id' do
        let(:monitor_id) { 12345 }

        let!(:response) { JSON.parse(monitor.find(monitor_id)) }

        it { expect(response['search']['id']).to eq 11111 }
        it { expect(response['search']['name']).to eq "[Dashboard] Cards Institucionais" }
        it { expect(response['search']['start_date']).to eq "01/11/2014" }
        it { expect(response['search']['search_results']).to eq 10641 }
        it { expect(response['search']['search_terms'].size).to eq 2 }
        it { expect(response['search']['search_terms'][0]['term']).to eq "Some Term" }
        it { expect(response['search']['search_terms'][1]['term']).to eq "some term" }
        it { expect(response['search']['tags']).to eq 10 }
        it { expect(response['search']['medias']).to eq 4 }
        it { expect(response['search']['active']).to be_falsy }
        it { expect(response['search']['sentiment_analysis']).to be_truthy }
      end

      context 'when does not exist monitor id' do
        xit "must be implemented"
      end
    end
  end

  describe '#tags' do
    before(:all) do
      Seekr.configure do |config|
        config.api_key = "apikey"
        config.api_secret = "secret"
      end
    end

    after(:all) do
      Seekr.reset
    end

    context 'when exists passed monitor id' do
      let(:monitor_id) { 12345 }

      let!(:response) { JSON.parse(monitor.tags(monitor_id)) }

      it { expect(response['tags'][0]['id']).to eq 1 }
      it { expect(response['tags'][0]['name']).to eq "Awesome Tag" }
      it { expect(response['tags'][0]['search_results']).to eq 53 }

      it { expect(response['tags'][1]['id']).to eq 2 }
      it { expect(response['tags'][1]['name']).to eq "Another Tag" }
      it { expect(response['tags'][1]['search_results']).to eq 37 }
    end

    context 'when does not exist monitor id' do
      xit "must be implemented"
    end
  end
end
