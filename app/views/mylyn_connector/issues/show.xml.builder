xml.instruct! :xml, :encoding => "UTF-8"
xml << render(:partial => 'issue.rxml', :locals => {:issue=>@issue} )
