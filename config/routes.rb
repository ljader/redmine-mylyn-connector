ActionController::Routing::Routes.draw do |map|
  #meta / settings
  map.connect "mylyn/settings", :controller => "MylynConnector::Settings", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/version", :controller => "MylynConnector::Information", :action => "version", :conditions => {:method => :get}

  #attributes
  map.connect "mylyn/customfields", :controller => "MylynConnector::CustomFields", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/issuecategories", :controller => "MylynConnector::IssueCategories", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/issuepriorities", :controller => "MylynConnector::IssuePriorities", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/versions", :controller => "MylynConnector::Versions", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/queries", :controller => "MylynConnector::Queries", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/users", :controller => "MylynConnector::Users", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/timeentryactivities", :controller => "MylynConnector::TimeEntryActivities", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/trackers", :controller => "MylynConnector::Trackers", :action => "all", :conditions => {:method => :get}
  map.connect "mylyn/issuestatus", :controller => "MylynConnector::IssueStatus", :action => "all", :conditions => {:method => :get}

  #projects
  map.connect "mylyn/projects", :controller => "MylynConnector::Projects", :action => "all", :conditions => {:method => :get}

  map.connect "mylyn/:project_id/search", :controller => "MylynConnector::Issues", :action => "query"
  map.connect "mylyn/search", :controller => "MylynConnector::Issues", :action => "query"
  map.connect "mylyn/:project_id/updatedsince", :controller => "MylynConnector::Issues", :action => "updated_since"
  map.connect "mylyn/issue/:id", :controller => "MylynConnector::Issues", :action => "show", :conditions => {:method => :get}
end
