xml.instruct! :xml, :encoding => "UTF-8"
xml.trackers root_attribs do
  @trackers.each do |tracker|
    xml.tracker :id => tracker.id do
      xml.name tracker.name
      xml.position tracker.position
      xml.issueCustomFields integer_list(tracker.custom_fields)
    end
  end
end
