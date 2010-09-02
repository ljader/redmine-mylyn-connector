require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::UsersController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods
  include MylynConnector::Version::ClassMethods

  accept_key_auth :all
  
  skip_before_filter :verify_authenticity_token

  helper MylynConnector::MylynHelper

  def all
    @users  = User.find(:all)

    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

end
