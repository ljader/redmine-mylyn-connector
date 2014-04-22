require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::IssueStatusControllerTest < MylynConnector::ControllerTest

  fixtures :issue_statuses

  def setup
    super
    @controller = MylynConnector::IssueStatusController.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/issue_status/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueStatus'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issueStatus'

    stats =  {:tag => 'issuestatuses', :children => {:count => 6}, :attributes => {:api => cr}}
    stat = {:tag => 'issuestatus', :attributes => {:id => 5}, :parent => stats}
    assert_tag :tag => 'name', :content => 'Closed', :parent => stat
    assert_tag :tag => 'isclosed', :content => 'true', :parent => stat
    assert_tag :tag => 'isdefault', :content => 'false', :parent => stat

  end

  def test_all_empty_is_valid
    IssueStatus.delete_all

    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/issue_status/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueStatus'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issueStatus'

    assert_tag :tag => 'issuestatuses', :children => {:count => 0}, :attributes => {:api => cr}
  end
end
