xml.instruct! :xml, :encoding => "UTF-8"
xml.timeEntryActivities root_attribs do
  @activities.each do |activity|
    xml.timeEntryActivity :id => activity.id do
      xml.name activity.name
      xml.position  activity.position
      xml.isDefault  activity.is_default
    end
  end
end
