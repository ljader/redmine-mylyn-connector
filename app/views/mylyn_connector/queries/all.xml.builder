xml.instruct! :xml, :encoding => "UTF-8"
xml.queries root_attribs do
  @queries.each do |query|
    xml.query :id => query.id do
      xml.name query.name
    end
  end
end
