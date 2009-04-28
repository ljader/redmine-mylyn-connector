require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::IssueStatusControllerTest < MylynConnector::ControllerTest

  fixtures :issue_statuses

  def setup
    super
    @controller = MylynConnector::IssueStatusController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueStatus'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issueStatus'

    assert_tag :tag => 'issuestatuses', :children => {:count => 6}
  end

  def test_all_empty_is_valid
    IssueStatus.delete_all

    get :all
    assert_response :success
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issueStatus'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'issueStatus'

    assert_tag :tag => 'issuestatuses', :children => {:count => 0}
  end
end
