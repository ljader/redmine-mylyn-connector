xml.instruct! :xml, :encoding => "UTF-8"
xml << render(:partial => 'partial_issue', :locals => {:issue=>@issue, :attr => root_attribs}, :formats => [:xml] )
