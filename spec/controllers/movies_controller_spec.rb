require 'rails_helper'
require 'spec_helper'

describe MoviesController, type: :controller do
    describe 'searching TMDb' do
      before :each do
        @fake_results = [double('movie1'), double('movie2')]
      end
      it 'calls the model method that performs TMDb search' do
        expect(Movie).to receive(:find_in_tmdb).with(
          { title: 'hardware', release_year: nil, language: nil }
        ).and_return(@fake_results)
        get :search_tmdb, params: { title: 'hardware' }
        end
      end
      describe 'after valid search' do
        before :each do
          allow(Movie).to receive(:find_in_tmdb).and_return(@fake_results)
          get :search_tmdb, params: { title: 'hardware' }
        it 'selects the Search Results template for rendering' do
          expect(response).to render_template('search_tmdb')
        end
        it 'makes the TMDb search results available to that template' do
          expect(assigns(:movies)).to eq(@fake_results)
        end
      end
    end
    describe 'adding a movie' do
        it 'adds the movie and redirects to search' do
          post :add_movie, params: {
            movie: {
              title: 'Test Movie',
              release_date: '2000-01-01',
              rating: 'R'
            }
          }

          expect(Movie.find_by(title: 'Test Movie')).to be_present
          expect(response).to redirect_to(search_tmdb_path)
        end
    end
  end