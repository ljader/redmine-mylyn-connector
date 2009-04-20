connect "mylyn/issue/:id", :controller => "MylynConnector::Issues", :action => "show", :conditions => {:method => :get}
connect "mylyn/projects", :controller => "MylynConnector::Projects", :action => "all", :conditions => {:method => :get}
