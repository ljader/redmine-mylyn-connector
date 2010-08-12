xml.instruct! :xml, :encoding => "UTF-8"
xml.issues :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  xml << render(:partial => 'partialissue.rxml', :collection => @issues,  :as => :issue) unless @issues.empty?
end
