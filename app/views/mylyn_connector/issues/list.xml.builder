xml.instruct! :xml, :encoding => "UTF-8"
xml.issues root_attribs do
  xml << render(:partial => 'issue.rxml', :collection => @issues) unless @issues.empty?
end
