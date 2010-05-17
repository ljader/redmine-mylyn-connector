xml.instruct! :xml, :encoding => "UTF-8"
xml.issuePriorities :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  @priorities.each do |priority|
    xml.issuePriority :id => priority.id do
      xml.name priority.name
      xml.position  priority.position
      xml.default  priority.is_default
    end
  end
end
