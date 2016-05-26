user_id=UserInfo.find_by_user_name("admin").id
cat_id=Cat.order("id asc").first.id
Blog.transaction do
  (1..100).each do |i|
    b=Blog.new(:title=>"i like ruby #{i}",
               :content_md=>%{i like ruby ,it is amazing #{i}},
               :user_id=>user_id,
               :cat_id=>cat_id
    )
    b.pre_handle
    b.save
  end
end