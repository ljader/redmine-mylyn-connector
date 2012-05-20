require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::PrioritiesControllerTest < MylynConnector::ControllerTest
  fixtures :enumerations

  def setup
    super
    @controller = MylynConnector::IssuePrioritiesController.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/issue_priorities/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issuePriorities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'issuePriorities'

    pris =  {:tag => 'issuepriorities', :children => {:count => 5}, :attributes => {:api => cr}}
    pri = {:tag => 'issuepriority', :attributes => {:id => 7}, :parent => pris}
    assert_tag pris
    assert_tag :tag => 'name', :content => 'Urgent', :parent => pri
    assert_tag :tag => 'position', :content => '4', :parent => pri
    assert_tag :tag => 'isdefault', :content => 'false', :parent => pri

  end

  def test_all_empty_is_valid
    IssuePriority.delete_all
 
    get :all, :format => 'xml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issuePriorities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'priorities'

    assert_tag :tag => 'issuepriorities', :children => {:count => 0}, :attributes => {:api => cr}
  end
end
