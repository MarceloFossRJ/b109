class ArtificialInput < SimpleForm::Inputs::BooleanInput
  # This method only create a basic input without reading any value from object
  def input
    template.check_box_tag(attribute_name, nil, input_html_options)
  end
end
