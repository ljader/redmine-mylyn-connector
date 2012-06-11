if Gem::Version.new("3.0") > Gem::Version.new(Rails.version) then
  #Routing for Redmine 1.x
  ActionController::Routing::Routes.draw do |map|
    map.with_options :format => 'xml', :conditions => {:method => :get} do |rmc|
      #meta / settings
      rmc.connect "mylyn/settings", :controller => "MylynConnector::Settings", :action => "all"
      rmc.connect "mylyn/version", :controller => "MylynConnector::Information", :action => "version"
      rmc.connect "mylyn/token", :controller => "MylynConnector::Information", :action => "token"
      #attributes
      rmc.connect "mylyn/customfields", :controller => "MylynConnector::CustomFields", :action => "all"
      rmc.connect "mylyn/issuecategories", :controller => "MylynConnector::IssueCategories", :action => "all"
      rmc.connect "mylyn/issuepriorities", :controller => "MylynConnector::IssuePriorities", :action => "all"
      rmc.connect "mylyn/versions", :controller => "MylynConnector::Versions", :action => "all"
      rmc.connect "mylyn/queries", :controller => "MylynConnector::Queries", :action => "all"
      rmc.connect "mylyn/users", :controller => "MylynConnector::Users", :action => "all"
      rmc.connect "mylyn/timeentryactivities", :controller => "MylynConnector::TimeEntryActivities", :action => "all"
      rmc.connect "mylyn/trackers", :controller => "MylynConnector::Trackers", :action => "all"
      rmc.connect "mylyn/issuestatus", :controller => "MylynConnector::IssueStatus", :action => "all"
      #projects
      rmc.connect "mylyn/projects", :controller => "MylynConnector::Projects", :action => "all"
      rmc.connect "mylyn/issue/:id", :controller => "MylynConnector::Issues", :action => "show"
      rmc.connect "mylyn/issues/updatedsince", :controller => "MylynConnector::Issues", :action => "updated_since"
      rmc.connect "mylyn/issues/list", :controller => "MylynConnector::Issues", :action => "list"
      rmc.connect "mylyn/issues", :controller => "MylynConnector::Issues", :action => "index"
      #very dirty workaround: enables RESTApiAuth for attachments
      rmc.connect 'mylyn/attachment/:id/:filename', :controller => 'attachments', :action => 'download', :format=> 'xml', :id => /\d+/, :filename => /.*/
    end
    map.connect 'mylyn/authtest', :controller => 'MylynConnector::Information', :action => 'authtest', :conditions => {:method => :get}
  end
else
  #Routing for Redmine 2.x
  RedmineApp::Application.routes.draw do
    #meta / settings
    get "mylyn/settings", :controller => 'mylyn_connector/settings', :action => 'all', :format => 'xml'
    get "mylyn/version", :controller => 'mylyn_connector/information', :action => 'version', :format => 'xml'
    get "mylyn/token", :controller => 'mylyn_connector/information', :action => 'token', :format => 'text'
    #attributes
    get "mylyn/customfields", :controller => 'mylyn_connector/custom_fields', :action => 'all', :format => 'xml'
    get "mylyn/issuecategories", :controller => 'mylyn_connector/issue_categories', :action => 'all', :format => 'xml'
    get "mylyn/issuepriorities", :controller => 'mylyn_connector/issue_priorities', :action => 'all', :format => 'xml'
    get "mylyn/versions", :controller => 'mylyn_connector/versions', :action => 'all', :format => 'xml'
    get "mylyn/queries", :controller => 'mylyn_connector/queries', :action => 'all', :format => 'xml'
    get "mylyn/users", :controller => 'mylyn_connector/users', :action => 'all', :format => 'xml'
    get "mylyn/timeentryactivities", :controller => 'mylyn_connector/time_entry_activities', :action => 'all', :format => 'xml'
    get "mylyn/trackers", :controller => 'mylyn_connector/trackers', :action => 'all', :format => 'xml'
    get "mylyn/issuestatus", :controller => 'mylyn_connector/issue_status', :action => 'all', :format => 'xml'
    #projects
    get "mylyn/projects", :controller => 'mylyn_connector/projects', :action => 'all', :format => 'xml'
    get "mylyn/issue/:id", :controller => 'mylyn_connector/issues', :action => 'show', :format => 'xml'
    get "mylyn/issues/updatedsince", :controller => 'mylyn_connector/issues', :action => 'updated_since', :format => 'xml'
    get "mylyn/issues/list", :controller => 'mylyn_connector/issues', :action => 'list', :format => 'xml'
    get "mylyn/issues", :controller => 'mylyn_connector/issues', :action => 'index', :format => 'xml'
    get 'mylyn/attachment/:id/:filename', :to => 'attachments#download', :format=> 'xml', :id => /\d+/, :filename => /.*/, :format => 'xml'
    get 'mylyn/authtest', :controller => 'mylyn_connector/information', :action => 'authtest', :format=> 'xml'
  end
end