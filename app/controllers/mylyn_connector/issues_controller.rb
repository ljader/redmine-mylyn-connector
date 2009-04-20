require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::IssuesController < ApplicationController
  unloadable

  before_filter :find_issue, :only => [:show]
  before_filter :find_project
  before_filter :authorize

  def show
    respond_to do |format|
      format.xml {render :xml => @issue, :template => 'mylyn_connector/issues/show.rxml'}
#      format.html {render :xml => @issue, :template => 'mylyn_connector/issues/show.rxml', :content_type => 'application/xml'}
    end
  end

  def query
  end

  private

  def authorize
    super :issues, :show ;
  end

  def find_issue
    @issue = Issue.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
  end

  def find_project
    @project = @issue.project
  end

end
