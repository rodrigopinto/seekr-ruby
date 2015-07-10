# encoding: utf-8
require 'spec_helper'

RSpec.describe 'Report' do
  let(:report) { Seekr::Report.new(12345) }

  describe '#general' do

    it_behaves_like "API authentication required" do
      let(:request) { report.general }
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

      context 'when exists monitor id' do
        let!(:response) { JSON.parse(report.general) }

        it { expect(response['report']['negative']).to eq 480 }
        it { expect(response['report']['negative_perc']).to eq 19.3 }
        it { expect(response['report']['neutral']).to eq 1156 }
        it { expect(response['report']['neutral_perc']).to eq 46.3 }
        it { expect(response['report']['positive']).to eq 847 }
        it { expect(response['report']['positive_perc']).to eq 34.4 }
        it { expect(response['report']['total']).to eq 2483 }
      end

      context 'when receive filter by date' do
        let!(:response) { JSON.parse(report.general(date_from: Time.zone.now.to_date, date_to: Time.zone.now.to_date)) }

        it { expect(response['report']['negative']).to eq 50 }
        it { expect(response['report']['negative_perc']).to eq 27.3 }
        it { expect(response['report']['neutral']).to eq 87 }
        it { expect(response['report']['neutral_perc']).to eq 47.3 }
        it { expect(response['report']['positive']).to eq 46 }
        it { expect(response['report']['positive_perc']).to eq 25.4 }
        it { expect(response['report']['total']).to eq 183 }
      end
    end
  end

  describe '#by_cities' do

    it_behaves_like "API authentication required" do
      let(:request) { report.by_cities }
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

      context 'when exists monitor id' do
        let(:response) { JSON.parse(report.by_cities) }
        let(:cities) { response['report']['cities'] }

        it { expect(cities['Santos']['negative']).to eq 1 }
        it { expect(cities['Santos']['negative_perc']).to eq 100.0 }
        it { expect(cities['Santos']['neutral']).to eq 0 }
        it { expect(cities['Santos']['neutral_perc']).to eq 0.0 }
        it { expect(cities['Santos']['positive']).to eq 0 }
        it { expect(cities['Santos']['positive_perc']).to eq 0.0 }
        it { expect(cities['Santos']['total']).to eq 1 }
      end

      context 'when receive filter by date' do
        xit "must be implemented"
      end
    end
  end

  describe '#by_tags' do

    it_behaves_like "API authentication required" do
      let(:request) { report.by_tags }
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

      context 'when exists monitor id' do
        let(:response) { JSON.parse(report.by_tags) }
        let(:tags) { response['report'] }

        it { expect(tags["Problemas/Engenharia/Ar Condicionado"]["total"]).to eq 12 }
        it { expect(tags["Problemas/Engenharia/Prateleira"]["total"]).to eq 1}
        it { expect(tags["Problemas/Engenharia/Acesso"]["total"]).to eq 10 }
      end

      context 'when receive filter by tag' do
        let(:response) { JSON.parse(report.by_tags(tag: [123])) }
        let(:tags) { response['report'] }

        it { expect(tags["Problemas/Engenharia/Ar Condicionado"]["total"]).to eq 12 }
        it { expect(tags["Problemas/Engenharia/Prateleira"]).to be_nil }
        it { expect(tags["Problemas/Engenharia/Acesso"]).to be_nil }
      end
    end
  end

  describe '#by_states' do

    it_behaves_like "API authentication required" do
      let(:request) { report.by_states }
    end

    context 'when API is authenticated' do
      before(:all) do
        Seekr.configure do |config|
          config.api_key = "apikey"
          config.api_secret = "apisecret"
        end
      end

      after(:all) do
        Seekr.reset
      end

      context 'when exists monitor id' do
        let(:response) { JSON.parse(report.by_states) }
        let(:states) { response['report']["states"] }

        it { expect(states.size).to eq 31 }
        it { expect(states["Rio de Janeiro"]['total']).to eq 3175 }
        it { expect(states["Rio de Janeiro"]['positive']).to eq 629 }
        it { expect(states["Rio de Janeiro"]['neutral']).to eq 1707 }
        it { expect(states["Rio de Janeiro"]['negative']).to eq 839 }

        it { expect(states["Goiás"]['total']).to eq 110 }
        it { expect(states["Goiás"]['positive']).to eq 26 }
        it { expect(states["Goiás"]['neutral']).to eq 63 }
        it { expect(states["Goiás"]['negative']).to eq 21 }
      end

      context 'when receive filter by date' do
        let(:response) { JSON.parse(report.by_states(date_from: Time.zone.now.to_date)) }
        let(:states) { response['report']['states'] }

        it { expect(states.size).to eq 9 }
        it { expect(states["Rio de Janeiro"]['total']).to eq 14 }
        it { expect(states["Rio de Janeiro"]['positive']).to eq 2 }
        it { expect(states["Rio de Janeiro"]['neutral']).to eq 6 }
        it { expect(states["Rio de Janeiro"]['negative']).to eq 6 }

        it { expect(states["Goiás"]).to be_nil }
      end
    end
  end

  describe '#by_words' do
    let!(:report) { Seekr::Report.new(16795) }

    it_behaves_like "API authentication required" do
      let(:request) { report.by_words }
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

      context 'when exists monitor id' do
        let(:response) { JSON.parse(report.by_words) }
        let(:words) { response['report'] }

        it { expect(words.size).to eq 3 }
        it { expect(words["#lojasamericanas"]["total"]).to eq 539 }
        it { expect(words["#lojasamericanas"]["negative"]).to eq 165 }
        it { expect(words["#lojasamericanas"]["positive"]).to eq 220 }
        it { expect(words["#lojasamericanas"]["neutral"]).to eq 154 }
        it { expect(words["agora"]).not_to be_empty }
        it { expect(words["@luansantana"]).not_to be_empty }
      end

      context 'when receive filter by date' do
        let(:response) { JSON.parse(report.by_words(date_from: Time.zone.now.to_date)) }
        let(:words) { response['report'] }

        it { expect(words.size).to eq 2 }
        it { expect(words["#lojasamericanas"]["total"]).to eq 239 }
        it { expect(words["#lojasamericanas"]["negative"]).to eq 59 }
        it { expect(words["#lojasamericanas"]["positive"]).to eq 120 }
        it { expect(words["#lojasamericanas"]["neutral"]).to eq 60 }
        it { expect(words["agora"]["total"]).to eq 92 }
        it { expect(words["agora"]["negative"]).to eq 36 }
        it { expect(words["agora"]["positive"]).to eq 50 }
        it { expect(words["agora"]["neutral"]).to eq 6 }
        it { expect(words["@luansantana"]).to be_nil }
      end
    end
  end

  describe '#by_people' do
    let!(:report) { Seekr::Report.new(16795) }

    it_behaves_like "API authentication required" do
      let(:request) { report.by_people }
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

      context 'when exists monitor id' do
        let(:response) { JSON.parse(report.by_people) }
        let(:users) { response['report'] }

        it { expect(users.size).to eq 3 }
        it { expect(users["john"]["total"]).to eq 539 }
        it { expect(users["john"]["negative"]).to eq 165 }
        it { expect(users["john"]["positive"]).to eq 220 }
        it { expect(users["john"]["neutral"]).to eq 154 }
        it { expect(users["quentin"]).not_to be_empty }
        it { expect(users["jack"]).not_to be_empty }
      end

      context 'when receive filter by date' do
        let(:response) { JSON.parse(report.by_people(date_from: Time.zone.now.to_date)) }
        let(:users) { response['report'] }

        it { expect(users.size).to eq 2 }
        it { expect(users["john"]["total"]).to eq 239 }
        it { expect(users["john"]["negative"]).to eq 59 }
        it { expect(users["john"]["positive"]).to eq 120 }
        it { expect(users["john"]["neutral"]).to eq 60 }
        it { expect(users["quentin"]["total"]).to eq 92 }
        it { expect(users["quentin"]["negative"]).to eq 36 }
        it { expect(users["quentin"]["positive"]).to eq 50 }
        it { expect(users["quentin"]["neutral"]).to eq 6 }
        it { expect(users["jack"]).to be_nil }
      end
    end
  end
end
