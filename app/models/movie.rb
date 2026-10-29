class Movie < ApplicationRecord
  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end

def self.find_in_tmdb(search_params, api_key = ENV['TMDB_API_KEY'] || 'test-key')    url = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{URI.encode_www_form_component(search_params[:title])}"
    url += "&language=en" if search_params[:language] == "en"
    url += "&year=#{search_params[:release_year]}" if search_params[:release_year].present?
    response = Faraday.get(url)
    results = JSON.parse(response.body)["results"]

    results.map do |result|
      Movie.new(
        title: result["title"],
        release_date: result["release_date"],
        rating: "R",
        description: result["overview"]
      )
    end
  end
  
  
end
