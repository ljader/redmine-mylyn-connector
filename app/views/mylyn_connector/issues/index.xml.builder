xml.instruct! :xml, :encoding => "UTF-8"
xml.issues root_attribs do
  xml << render(:partial => 'partialissue.rxml', :collection => @issues,  :as => :issue) unless @issues.empty?
end
