ActionController::Routing::Routes.draw do |map|
  map.connect "mylyn/issue/:id", :controller => "MylynConnector::Issues", :action => "show", :conditions => {:method => :get}
  map.connect "mylyn/projects", :controller => "MylynConnector::Projects", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/priorities", :controller => "MylynConnector::Priorities", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/activities", :controller => "MylynConnector::Activities", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/issuestatus", :controller => "MylynConnector::IssueStatus", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/customfields", :controller => "MylynConnector::CustomFields", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/version", :controller => "MylynConnector::Information", :action => "version", :conditions => {:method => :get}
  map.connect "mylyn/:project_id/search", :controller => "MylynConnector::Issues", :action => "query"
  map.connect "mylyn/search", :controller => "MylynConnector::Issues", :action => "query"
  map.connect "mylyn/:project_id/updatedsince", :controller => "MylynConnector::Issues", :action => "updated_since"
end
