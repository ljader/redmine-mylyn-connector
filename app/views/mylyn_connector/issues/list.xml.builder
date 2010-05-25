xml.instruct! :xml, :encoding => "UTF-8"
xml.issues :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  xml << render(:partial => 'issue.rxml', :collection => @issues) unless @issues.empty?
end
