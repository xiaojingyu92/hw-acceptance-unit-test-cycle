class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.same_director movie_title
    director = Movie.find_by(title: movie_title).director
    return nil if director.blank? or director.nil?
    Movie.where(director: director).pluck(:title)
  end

end
