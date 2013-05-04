module ApplicationHelper

  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def menu_type_combo
    r = [['Root',1],['Children',2],['Blog',3],['Home',4],['Header',5],['Separator',6]]
    return r
  end

  def parameter_type_combo
    r = [['String',1],['Integer',2],['Number',3],['Date',4],['DateTime',5],['Currency',6]]
    return r
  end

  def parameter_root_page
    a = [['Blog','blog']] + Page.all.map {|page| [page.title, page.id]} 
    return a
  end  

  def true_false
    a = [['True','true'], ['False', 'false']] 
    return a
  end
end
