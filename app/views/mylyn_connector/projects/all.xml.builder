xml.instruct! :xml, :encoding => "UTF-8"
xml.projects root_attribs do
  xml << render(:partial => 'project.rxml', :collection => @projects) unless @projects.empty?
end
