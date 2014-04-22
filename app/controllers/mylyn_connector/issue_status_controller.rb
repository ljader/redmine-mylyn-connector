require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::IssueStatusController < MylynConnector::ApplicationController
  unloadable

  accept_api_auth :all
  skip_before_filter :verify_authenticity_token
  helper MylynConnector::MylynHelper

  def all
    @issue_status = IssueStatus.find(:all)

    respond_to do |format|
      format.xml {render :layout => nil}
    end
  end
end
