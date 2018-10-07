class Exercise < ApplicationRecord
  has_many :solutions, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  # mount_uploader :avatar, AvatarUploader
  enum difficulty: [:easy, :medium, :hard]
  validates :difficulty, presence: true

  def self.tagged_with(name)
    Tag.find_by!(name: name).exercises
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
