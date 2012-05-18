xml.instruct! :xml, :encoding => "UTF-8"
xml.projects root_attribs do
  xml << render(:partial => 'project', :collection => @projects, :formats => [:xml]) unless @projects.empty?
end
