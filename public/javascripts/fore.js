// Place your fore-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var row_template='<div class="{rowclass}"><div class="cmt-meta"><span class="cmt-author">{author}</span><span class="cmt-time">{time}</span></div><div class="cmt-content">{content}</div></div>';
function listComment(blog_id){
    $.getJSON("/comment_list/"+blog_id,
        function(array){
            var cmt_list_html="";
            $.each(array,function(index,item){
                cmt_list_html+=row_template.
                replace("{rowclass}", "cmt-one").
                replace("{author}", item.email).
                replace("{time}", item.created_at).
                replace("{content}", item.content);
            });
            $(".cmt-list").html(cmt_list_html);
        }
    );
}
