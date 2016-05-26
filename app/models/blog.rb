class Blog < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :title
  validates_presence_of :cat_id
  validates_presence_of :content_md
  belongs_to :cat
  has_many :comments

  #assign the hash(params[:blog] from form) to attribute of model
  def assgin_attributes(hash={})
    hash.each do |key,value|
      self[key]=value #if self.has_key?(key)
    end
  end

  #handle some attribute before insert or update
  def pre_handle
    self.title_en=self.title#todo convert title to en
    self.content=Kramdown::Document.new(self.content_md).to_html#convert md to content
    if not self.intro.present?
      #do not use self.content[0,len],it not work when contains chinese character
      tmp=ActionController::Base.helpers.truncate( self.content,:length=> 100)
      self.intro=tmp +'......'
    end
    if not self.seo_title.present?
      self.seo_title=self.title
    end
    if not self.seo_keyword.present?
      self.seo_keyword=self.title
    end
    if not self.seo_desc.present?
      self.seo_desc=self.title
    end
  end

  def Blog.blog_count(cat_id)
    return Blog.count(:conditions => ["cat_id=#{cat_id}"])
  end
  #the read count of blog plus 1
  def plus_read_count
    if self.id
      new_value=self.read_count+1
      update_attributes(:read_count=>new_value)
      self.read_count=new_value
    end
  end

  def comment_count
    return Comment.count_under_blog(self.id)
  end
end
