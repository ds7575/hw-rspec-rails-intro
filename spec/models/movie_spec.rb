require 'rails_helper'

describe Movie, type: :model do
    describe 'searching Tmdb by keyword' do
        it 'calls Faraday gem with CS169 domain' do
        expect(Faraday).to receive(:get).and_call_original
        Movie.find_in_tmdb({ title: 'hacker', language: 'en' }, 'test-key')
        end
        it 'calls Tmdb with valid API key' do
            results = Movie.find_in_tmdb({ title: 'hacker', language: 'en' }, 'test-key')
            expect(results.length).to eq(2)
        end

    end
end