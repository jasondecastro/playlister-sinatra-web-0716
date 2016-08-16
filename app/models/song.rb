class Song < ActiveRecord::Base
  belongs_to :artist

  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    test = slug.gsub("-", " ").gsub(/\w+/, &:capitalize)
    self.find_by(name: test)
  end
end