class MylynConnector::ApplicationController < ApplicationController
  unloadable
  
  include MylynConnector::Rescue
  
  before_filter :require_login #Require a successful login to render page

end
