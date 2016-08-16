class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres

  has_many :artists, through: :songs

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    test = slug.gsub("-", " ").gsub(/\w+/, &:capitalize)
    self.find_by(name: test)
  end
end