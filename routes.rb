connect "mylyn/issue/:id", :controller => "MylynIssues", :action => "get"
map.resources :issues do |issues|
  issues.resources :status
 end