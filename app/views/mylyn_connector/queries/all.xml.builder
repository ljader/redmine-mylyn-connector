xml.instruct! :xml, :encoding => "UTF-8"
xml.queries :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  @queries.each do |query|
    xml.query :id => query.id do
      xml.name query.name
    end
  end
end
