require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::ProjectsController < MylynConnector::ApplicationController
  unloadable

  accept_api_auth :all
  skip_before_filter :verify_authenticity_token
  helper MylynConnector::MylynHelper

  def all
    @projects = Project
      .where("enabled_modules.name = 'issue_tracking' AND #{Project.visible_condition(User.current)}")
      .joins(:enabled_modules)
      .to_a

    respond_to do |format|
      format.xml {render :layout => nil}
    end
  end
  
end
