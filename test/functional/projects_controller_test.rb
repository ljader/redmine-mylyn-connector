require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::ProjectsControllerTest < MylynConnector::ControllerTest

  fixtures :users, :roles, :members, :issue_categories, :custom_fields, :trackers, :versions, :queries, :projects, :projects_trackers, :enabled_modules, :custom_fields_trackers
  
  def setup
    super
    @controller = MylynConnector::ProjectsController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'projects'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'projects'

    # only projects 1+3 are public and have issue-tracking enabled
    assert_tag :tag => 'projects', :children => {:count => 2, :only => {:tag => 'project', :child => {:tag => 'issueeditallowed', :content => 'false'}}}
  end

  def test_all_authenticated
    @request.session[:user_id] = 2

    get :all
    assert_response :success
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'projects'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'projects'

    assert_tag :tag => 'projects', :children => {:count => 4, :only => {:tag => 'project', :child => {:tag => 'issueeditallowed', :content => 'true'}}}
  end

end
