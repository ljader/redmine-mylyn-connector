xml.instruct! :xml, :encoding => "UTF-8"
xml.customFields root_attribs do
  @custom_fields.each do |field|
    xml.customField :id => field.id do
      xml.name field.name
      xml.type field.type
      xml.fieldFormat field.field_format
      xml.minLength field.min_length
      xml.maxLength field.max_length
      xml.regexp field.regexp
      if field.possible_values && field.possible_values.kind_of?(Array)
        xml.possibleValues {
          field.possible_values.each {|value|xml.possibleValue value}
        }
      else
        xml.possibleValues
      end
      xml.defaultValue field.default_value
      xml.isRequired field.is_required
      xml.isFilter field.is_filter
      xml.isForAll field.is_for_all
    end
  end
end
