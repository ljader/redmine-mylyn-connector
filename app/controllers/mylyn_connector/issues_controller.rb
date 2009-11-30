require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::IssuesController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token

  before_filter :find_issue, :only => [:show]
  before_filter :find_project
  before_filter :authorize, :except => [:query]

  helper MylynConnector::WatchersHelper
  
  def show
    respond_to do |format|
      format.xml {render :xml => @issue, :template => 'mylyn_connector/issues/show.rxml'}
      #      format.html {render :xml => @issue, :template => 'mylyn_connector/issues/show.rxml', :content_type => 'application/xml'}
    end
  end

  def query
    query = retrieve_query params[:query_id], params[:query_string]
    if !query.blank? && query.valid?
      begin

        condition = ARCondition.new
        condition << ["issues.project_id = ?", @project.id] if @project
        condition << query.statement

        @issues = Issue.find :all,
          :include => [ :assigned_to, :status, :tracker, :project, :priority, :category, :fixed_version ],
          :conditions => condition.conditions

        respond_to do |format|
          format.xml {render :xml => @issues, :template => 'mylyn_connector/issues/index.rxml'}
        end
      rescue ActiveRecord::StatementInvalid
        render_404
      end
    else
      render_404
    end
  end

  def updated_since

    time = Time.at(params[:unixtime].to_i)
    cond = ActiveRecord::Base.connection.quoted_date(time)

    @issues = Issue.find(:all, :conditions => ["project_id = ? AND updated_on >= ?", @project.id, cond])
    respond_to do |format|
      format.xml {render :xml => @issues, :template => 'mylyn_connector/issues/updated_since.rxml'}
    end
  end

  private

  def authorize
    super :issues, params[:action]=='query' ? :index : :show;
  end

  def find_issue
    @issue = Issue.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_project
    if @issue
      @project = @issue.project
    elsif !params[:project_id].blank?
      begin
        @project = Project.find(params[:project_id])
      rescue ActiveRecord::RecordNotFound
        render_404
      end
    end
  end

  def retrieve_query query_id, query_string
    query = nil
    if query_id!=nil && query_id.to_i>0 then
      begin
        # Code form Issue_helper
        visible = ARCondition.new(["is_public = ? OR user_id = ?", true, User.current.id])
        visible << (["project_id IS NULL OR project_id = ?", @project.id]) if @project

        query = Query.find(query_id, :conditions => visible.conditions)
      rescue
        query = Query.new
      end
      query.project = @project if @project
    else
      querydecoder = MylynConnector::QueryStringDecoder.new(query_string)
      query = querydecoder.query
    end
    return query
  end
end
