xml.instruct! :xml, :encoding => "UTF-8"
xml.issueCategories root_attribs do
  @issue_categories.each do |status|
    xml.issueCategory :id => status.id do
      xml.name status.name
    end
  end
end
