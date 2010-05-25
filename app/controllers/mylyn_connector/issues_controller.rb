require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::IssuesController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token

  before_filter :find_issue, :only => [:show]
  before_filter :find_project, :only => [:show]
  before_filter :authorize

  helper MylynConnector::MylynHelper
  
  def show
    respond_to do |format|
      format.xml {render :layout => false}
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

    issues = params[:issues].split(',')
    issues.collect! { |x| x.to_i }
    issues.uniq!
    issues.compact!

    cond = ActiveRecord::Base.connection.quoted_date(time)

    @issues = Issue.find(
      :all,
      :joins => ["join #{Project.table_name} on project_id=#{Project.table_name}.id"],
      :conditions => ["#{Issue.table_name}.id in (?) and #{Issue.table_name}.updated_on >= ? and " << Project.visible_by, issues, cond]
    )
    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

  def list
    issues = params[:issues].split(',')
    issues.collect! { |x| x.to_i }
    issues.uniq!
    issues.compact!

    @issues = Issue.find(
      :all,
      :joins => ["join #{Project.table_name} on project_id=#{Project.table_name}.id"],
      :conditions => ["#{Issue.table_name}.id in (?) and " << Project.visible_by, issues]
    )
    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

  private

  def authorize
    if @project
      super :issues, :show;
    else
      super :issues, :show, true
    end
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
