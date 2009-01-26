# == Schema Information
# Schema version: 20081201012648
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug
  
  belongs_to :parent, :class_name => 'Category'
  has_many   :children, :class_name => 'Category', :foreign_key => 'parent_id', :dependent => :destroy
  
  named_scope :root, :conditions => 'parent_id is NULL'

  before_validation :setup_slug

  def to_s
    name
  end

  private

  # Build a slug from the name if user didn't supply one
  def setup_slug
    self.slug = name.to_s.downcase.strip.gsub(/[^a-zA-Z0-9]+/,'-') unless self.slug?
  end
end
