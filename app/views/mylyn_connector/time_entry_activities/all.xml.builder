xml.instruct! :xml, :encoding => "UTF-8"
xml.timeEntryActivities :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  @activities.each do |activity|
    xml.timeEntryActivity :id => activity.id do
      xml.name activity.name
      xml.position  activity.position
      xml.default  activity.is_default
    end
  end
end
