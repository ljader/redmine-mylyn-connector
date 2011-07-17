require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::InformationController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  accept_key_auth :version, :token #Redmine<1.2
  accept_api_auth :version, :token, :authtest #Redmine>=1.2

  skip_before_filter :verify_authenticity_token

  helper MylynConnector::MylynHelper
  
  def version
    @data = MylynConnector::Version.to_a

    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

  def token
    #Workaround: we need a session, some operations does'nt support key-auth
    self.logged_user = User.current unless User.current.anonymous?
    
    render :text => form_authenticity_token
  end

  def authtest

    authenticate_with_http_basic do |username, password|
      if user = User.try_to_login(username, password)
        txt =  'Hello ' + user.name + ' - your HTTP-Basic-Authentication does work properly.'
        txt += ' <b>But you have to enable the Rest-API!</b>' unless Setting.rest_api_enabled?;

        render :text =>  txt
        return
      end
    end

    head :unauthorized, 'WWW-Authenticate' => 'Basic realm="Redmine API"'

  end
end
