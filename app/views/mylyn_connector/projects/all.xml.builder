xml.instruct! :xml, :encoding => "UTF-8"
xml.projects :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  xml << render(:partial => 'project.rxml', :collection => @projects) unless @projects.empty?
end
