module ForeHelper
=begin
<div class="errorExplanation" id="errorExplanation"><h2>2 errors prohibited this comment from being saved</h2><p>There were problems with the following fields:</p><ul><li>Email can't be blank</li><li>Content can't be blank</li></ul></div>
to
<div class="panel panel-danger"><div class="panel-heading">2 errors prohibited this comment from being saved</div><p>There were problems with the following fields:</p><ul class="list-group"><li class="list-group-item">Email cant be blank</li><li>Content cant be blank</li></ul></div>
=end
  def error_for_boostrap_style(model)
    error_str=error_messages_for(model)
    error_str= error_str.gsub(/'/,'')
    error_str=error_str.gsub(/<div class="errorExplanation" id="errorExplanation">/,'<div class="panel panel-danger">')
    error_str=error_str.gsub(/<h2>/,'<div class="panel-heading">')
    error_str=error_str.gsub(/<\/h2>/,'</div>')
    error_str=error_str.gsub(/<p>.*?<\/p>/,'')
    error_str=error_str.gsub(/<ul>/,'<ul class="list-group">')
    error_str=error_str.gsub(/<li>/,'<li class="list-group-item">')
    #logger.info "error_str:#{error_str}"
    error_str=sanitize(error_str)
    return error_str
  end
end
