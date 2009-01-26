class AddSlugToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :slug, :string, :default => ''
    Category.all.each do |c|
      say "Updating category '#{c}' to generate slug"
      c.save
    end
  end

  def self.down
    remove_column :categories, :slug
  end
end
