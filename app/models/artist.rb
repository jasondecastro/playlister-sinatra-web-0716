class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    test = slug.gsub("-", " ").gsub(/\w+/, &:capitalize)
    self.find_by(name: test)
  end
end