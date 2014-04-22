require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::CustomFieldsControllerTest < MylynConnector::ControllerTest

  fixtures :custom_fields

  def setup
    super
    @controller = MylynConnector::CustomFieldsController.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/custom_fields/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'customFields'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'customFields'

    cfl = {:tag => 'customfields', :children => {:count => 11}, :attributes => {:api => cr}}
    cf = {:tag => 'customfield', :attributes => {:id => 1}, :parent => cfl}
    assert_tag :tag => 'name', :content => 'Database', :parent => cf
    assert_tag :tag => 'type', :content => 'IssueCustomField', :parent => cf
    assert_tag :tag => 'fieldformat', :content => 'list', :parent => cf
    assert_tag :tag => 'isrequired', :content => 'false', :parent => cf
    assert_tag :tag => 'isfilter', :content => 'true', :parent => cf
    assert_tag :tag => 'isforall', :content => 'true', :parent => cf

  end

  def test_all_empty_is_valid
    CustomField.delete_all

    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/custom_fields/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'customFields'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'customFields'

    assert_tag :tag => 'customfields', :children => {:count => 0},  :attributes => {:api => cr}
  end
end
