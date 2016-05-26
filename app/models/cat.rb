class Cat < ActiveRecord::Base
  validates_presence_of(:cat_name)
  validates_uniqueness_of(:cat_name)
  has_many :blogs

  #assign the hash(params[:blog] from form) to attribute of model
  def assgin_attributes(hash={})
    hash.each do |key,value|
      self[key]=value #if self.has_key?(key)
    end
  end

  def Cat.list_options
    return Cat.order('id asc').select('id,cat_name').collect do |c|
      [c.cat_name,c.id]
    end
  end

  def Cat.list_cats
    return Cat.order('id asc').select('id,cat_name').all
  end

  def blog_count
    return Blog.blog_count(self.id)
  end
end
