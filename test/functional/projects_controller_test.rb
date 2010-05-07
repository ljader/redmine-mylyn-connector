require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::ProjectsControllerTest < MylynConnector::ControllerTest

  class << self

    def fixtures(*table_names)
      dir = File.join(File.dirname(__FILE__), "../../test/fixtures/" + self.rr)
      Fixtures.create_fixtures(dir, "custom_fields")

      #TODO since 0.9 MemberRole exists
      table_names.push(:member_roles) if Object.const_defined?(:MemberRole)

      super(table_names)
    end

  end

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

    p = {:tag => 'project', :attributes => { :id => '1'}}
    assert_tag :tag => 'identifier', :content => 'ecookbook', :parent => p
    assert_tag :tag => 'tracker', :attributes => {:id => 2}, :children => {:only => {:tag => 'name', :content => 'Feature request'}}, :parent => {:tag => 'trackers', :children => {:count => 3}, :parent => p}


    if is09?
#      1  0.1  closed
#      2  1.0  locked
#      3  2.0  open
#      4  2.0  open
#      6  Private Version of public subproject  open # shared version don't respects the provacy of projects
#      7  Systemwide visible version  open

      v = {:tag=> 'versions', :children => {:count => 6}, :parent => p}
      assert_tag v
      assert_tag :tag => 'version', :attributes => {:id => 1}, :child => {:tag => 'name', :content => '0.1', :sibling => {:tag => 'open', :content => 'false'}}, :parent =>v
      assert_tag :tag => 'version', :attributes => {:id => 7}, :child => {:tag => 'name', :content => 'Systemwide visible version (OnlineStore)', :sibling => {:tag => 'open', :content => 'true'}}, :parent =>v
    else
      assert_tag :tag => 'version', :attributes => {:id => 3}, :children => {:only => {:tag => 'name', :content => '2.0', :sibling => {:tag => 'completed', :content => 'true'}}}, :parent => {:tag => 'versions', :children => {:count => 3}, :parent => p}
      assert_tag :tag => 'version', :attributes => {:id => 2}, :children => {:only => {:tag => 'name', :content => '1.0', :sibling => {:tag => 'completed', :content => 'false'}}}, :parent => {:tag => 'versions', :parent => p}
    end


    assert_tag :tag => 'member', :attributes => {:id => 2}, :children => {:only => {:tag => 'name', :content => 'John Smith', :sibling => {:tag => 'assignable', :content => 'true'}}}, :parent => {:tag => 'members', :parent => p}
    assert_tag :tag => 'issuecategory', :attributes => {:id => 2}, :children => {:only => {:tag => 'name', :content => 'Recipes'}}, :parent => {:tag => 'issuecategories', :children => {:count => 2}, :parent => p}
    #redmine 0.8: 2 customfields
    #redmine 0.9: 3 customfields
    assert_tag :tag => 'issuecustomfield', :attributes => {:id => 1}, :children => {:only => {:tag => 'name', :content => 'Database', :sibling => {:tag => 'fieldformat', :content => 'list', :sibling => {:tag => 'trackers', :content => '1', :sibling => {:tag => 'required', :content => 'false', :sibling => {:tag => 'filter', :content => 'true', :sibling => {:tag => 'forAll', :content => 'true'}}}}}}}, :parent => {:tag => 'issuecustomfields', :children => {:count => 2..3}, :parent =>p}
    #redmine 0.8: 2 queries
    #redmine 0.9: 5 queries
    assert_tag :tag => 'query', :attributes => {:id => 1}, :children => {:only => {:tag => 'name', :content => 'Multiple custom fields query'}}, :parent => {:tag => 'queries', :children => {:count => 2..5}, :parent => p}
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
