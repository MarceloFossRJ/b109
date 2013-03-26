module PostsHelper
  def add_tag_link(form_builder)
    link_to_function 'add Tag',nil do |page|
      form_builder.fields_for :tags, Tag.new, :child_index => 'NEW_RECORD' do |f|
        html = render(:partial => 'tag', :locals => { :form_tag => f })
        page << "$('tags').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
        logger.debug page.inspect
      end
    end
  end

  def remove_tag_link(form_builder)
    if form_builder.object.new_record?
      # If the task is a new record, we can just remove the div from the dom
      link_to_function("remove", "$(this).up('.tag').remove();");
    else
      # However if it's a "real" record it has to be deleted from the database,
      # for this reason the new fields_for, accept_nested_attributes helpers give us _delete,
      # a virtual attribute that tells rails to delete the child record.
      form_builder.hidden_field(:_destroy) +
              link_to_function("remove", "$(this).up('.tag').hide(); $(this).previous().value = '1'")
    end
  end
end
