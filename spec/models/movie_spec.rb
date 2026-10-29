require 'rails_helper'

describe Movie, type: :model do
    describe 'searching Tmdb by keyword' do
        it 'calls Faraday gem with CS169 domain' do
        expect(Faraday).to receive(:get).with(
            a_string_including('api_key=test-key', 'query=hacker', 'language=en')
        ).and_call_original
        Movie.find_in_tmdb({ title: 'hacker', language: 'en' }, 'test-key')
        end
        it 'calls Tmdb with valid API key' do
            results = Movie.find_in_tmdb({ title: 'hacker', language: 'en' }, 'test-key')
            expect(results.length).to eq(2)
        end
        it 'includes the release year and omits language for all languages' do
        expect(Faraday).to receive(:get).with(
            a_string_including('query=Manhunter', 'year=1986')
        ).and_call_original
        Movie.find_in_tmdb(
            { title: 'Manhunter', release_year: '1986', language: 'all' },
            'test-key'
        )
        end
        it 'escapes spaces and plus signs in the title' do
        expect(Faraday).to receive(:get).with(
            a_string_including('query=This+Life+%2B10')
        ).and_call_original
        Movie.find_in_tmdb(
            { title: 'This Life +10', language: 'all' },
            'test-key'
        )
        end

    end
end