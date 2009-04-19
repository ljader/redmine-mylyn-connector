connect "mylyn/issue/:id", :controller => "MylynConnector::Issues", :action => "get"
connect "mylyn/query", :controller => "MylynConnector::Issues", :action => "query"
map.resources :issues do |issues|
  issues.resources :status
 end