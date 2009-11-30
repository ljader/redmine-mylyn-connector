require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::IssueStatusController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token

  def all
    @issue_status = IssueStatus.find(:all)

    respond_to do |format|
      format.xml {render :xml => @issue_status, :template => 'mylyn_connector/issue_status/all.rxml'}
    end
  end
end
