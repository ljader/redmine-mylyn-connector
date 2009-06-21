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
    query = retrieve_query params[:query_id], params[:query_string]
    if !query.blank? && query.valid?
      begin

        #workaround: sometimes (why ?!), query dosn't contains the correct project
        condition = ARCondition.new(["issues.project_id = ?", @project.id])
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
    if params[:project_id].blank?
      @project = @issue.project
    else
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
        visible << (["project_id IS NULL OR project_id = ?", @project.id])

        query = Query.find(query_id, :conditions => visible.conditions)
      rescue
        query = Query.new
      end
      query.project = @project
    else
      querydecoder = MylynConnector::QueryStringDecoder.new(query_string)
      query = querydecoder.query
    end
    return query
  end
end
