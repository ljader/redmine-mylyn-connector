xml.instruct! :xml, :encoding => "UTF-8"
xml << render(:partial => 'list_issue', :locals => {:issue=>@issue, :attr => root_attribs}, :formats => [:xml] )
