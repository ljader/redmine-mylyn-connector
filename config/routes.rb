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


  #very dirty workaround: enables REST-Api-Auth for attachments
  get 'mylyn/attachment/:id/:filename', :to => 'attachments#download', :format=> 'xml', :id => /\d+/, :filename => /.*/, :format => 'xml'

  get 'mylyn/authtest', :controller => 'mylyn_connector/information', :action => 'authtest', :format=> 'xml'
end
