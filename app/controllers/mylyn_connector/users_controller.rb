require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::UsersController < MylynConnector::ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods
  include MylynConnector::Version

  accept_api_auth :all
  
  skip_before_filter :verify_authenticity_token

  helper MylynConnector::MylynHelper

  def all
    @users  = User.find(:all)

    respond_to do |format|
      format.xml {render :layout => nil}
    end
  end

end
