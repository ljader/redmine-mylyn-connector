xml.instruct! :xml, :encoding => "UTF-8"
xml << render(:partial => 'issue.rxml', :locals => {:issue=>@issue, :attr => {:xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version}} )
