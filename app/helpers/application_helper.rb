module ApplicationHelper
  def get_menu_item_class(item_name,controller,action_name)
    css=""
    ca=controller.class.name.downcase.gsub("controller","")+"#"+action_name.downcase
    if item_name==ca
      css="active"
    end
    return css
  end
end
