require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::IssuesControllerTest < MylynConnector::ControllerTest

  fixtures :users, :roles, :members, :issue_categories, :custom_fields, :trackers, :versions, :queries, :projects, :projects_trackers, :custom_fields_trackers, :issues, :journals, :attachments, :custom_fields, :custom_values

  def setup
    super
    @controller = MylynConnector::IssuesController.new
  end

  def test_show
    get :show, :id => 1
    assert_response :success
    assert_template 'show.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issue'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issue'

    assert_tag :tag => 'issue', :attributes => {:id => 1}
    assert_tag :tag => 'subject', :content => 'Can\'t print recipes'
    assert_tag :tag => 'description',:content => 'Unable to print recipes'
    assert_tag :tag => 'author', :content => 'John Smith'
    assert_tag :tag => 'projectid', :content => '1'
    assert_tag :tag => 'trackerid', :content => '1'
    assert_tag :tag => 'priorityid', :content => '4'
    assert_tag :tag => 'statusid', :content => '1'
    assert_tag :tag => 'categoryid', :content => '1'
    assert_no_tag :tag => 'fixedversionid'
    assert_no_tag :tag => 'assignedtoid'
    assert_tag :tag => 'doneratio', :content => '0'
    assert_no_tag :tag=> 'estimatedhours'
    assert_tag :tag => 'availablestatus', :content => '1'
    #redmine 0.8: 1
    #redmine 0.9: 2
    assert_tag :tag => 'customvalues', :children => {:count => (1..2)}
    assert_tag :tag => 'customvalue', :parent  => {:tag => 'customvalues'}, :attributes => {:customfieldid => '2'}, :content => '125'
    assert_tag :tag => 'journals', :children => {:count => 2}
    assert_tag :tag => 'author', :parent  => {:tag => 'journal'}, :content => 'redMine Admin'
    assert_tag :tag => 'notes', :parent  => {:tag => 'journal'}, :content => 'Journal notes'
    assert_tag :tag => 'editablebyuser', :parent  => {:tag => 'journal'}, :content => 'false'
    assert_tag :tag => 'attachments', :children => {:count => 0}
    #issuerelations
  end

  def test_show_attachement
    get :show, :id => 3
    assert_response :success
    assert_template 'show.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issue'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issue'

    assert_no_tag :tag => 'categoryid', :content => '1'
    assert_no_tag :tag => 'fixedversionid'
    assert_tag :tag => 'assignedtoid', :content => '3'
    assert_tag :tag => 'attachments', :children => {:count => 4}
    assert_tag :tag => 'author', :parent  => {:tag => 'attachment'}, :content => 'John Smith'
    assert_tag :tag => 'contenttype', :parent  => {:tag => 'attachment'}, :content => 'text/plain'
    assert_tag :tag => 'filename', :parent  => {:tag => 'attachment'}, :content => 'error281.txt'
    assert_tag :tag => 'filesize', :parent  => {:tag => 'attachment'}, :content => '28'
    assert_tag :tag => 'digest', :parent  => {:tag => 'attachment'}, :content => 'b91e08d0cf966d5c6ff411bd8c4cc3a2'
    #issuerelations
  end

  def test_show_assigned
    get :show, :id => 2
    assert_response :success
    assert_template 'show.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issue'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issue'

    assert_tag :tag => 'fixedversionid', :content => '2'
    assert_tag :tag => 'assignedtoid', :content => '3'
  end

  def test_show_404
    get :show, :id => 99
    assert_response 404
  end

  def test_query_by_id
    get :query, :project_id => 1, :query_id => 1

    assert_response :success
    assert_template 'index.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issues'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issues'

    assert_tag :tag => 'issues', :children => {:count => 1}
    assert_tag :tag => 'issue', :attributes => {:id => 3}
  end

  def test_query_by_string
    post :query, :project_id => 1, :query_string => 'project_id=1&set_filter=1&fields[]=tracker_id&operators[tracker_id]=%3D&values[tracker_id][]=1'

    assert_response :success
    assert_template 'index.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issues'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issues'

    assert_tag :tag => 'issues', :children => {:count => 3}
  end

  def test_query_non_exists
    get :query, :project_id => 1, :query_id => 99
    assert_response 404
  end

  def test_updated_since
    get :updated_since, :project_id => 1, :unixtime => 11.days.ago.to_i

    assert_response :success
    assert_template 'updated_since.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'updatedIssues'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'updatedIssues'

    #redmine 0.8: 1 & 7
    #redmine 0.9: 1,7 & 8
    assert_tag :tag => 'updatedissues', :content => /1 7( 8)?/
  end

end
