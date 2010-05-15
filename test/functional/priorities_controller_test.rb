require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::PrioritiesControllerTest < MylynConnector::ControllerTest
  fixtures :enumerations

  def setup
    super
    @controller = MylynConnector::PrioritiesController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.xml.builder'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issuePriorities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'priorities'

    pris =  {:tag => 'priorities', :children => {:count => 5}, :attributes => {:api => /^2.7.0/}}
    pri = {:tag => 'priority', :attributes => {:id => 7}, :parent => pris}
    assert_tag :tag => 'name', :content => 'Urgent', :parent => pri
    assert_tag :tag => 'position', :content => '4', :parent => pri
    assert_tag :tag => 'default', :content => 'false', :parent => pri

  end

  def test_all_empty_is_valid
    IssuePriority.delete_all
 
    get :all

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'issuePriorities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'priorities'

    assert_tag :tag => 'priorities', :children => {:count => 0}, :attributes => {:api => /^2.7.0/}
  end
end
