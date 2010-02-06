require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::CustomFieldsControllerTest < MylynConnector::ControllerTest

  fixtures :custom_fields

  def setup
    super
    @controller = MylynConnector::CustomFieldsController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'customFields'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'customFields'

    #Redmine0.8 5
    #Redmine0.9 9
    assert_tag :tag => 'customfields', :children => {:count => 5..9}
    assert_tag :tag => 'customfield', :attributes => {:id => 1}, :children => {:only => {:tag => 'name', :content => 'Database', :sibling => {:tag => 'fieldformat', :content => 'list', :sibling => {:tag => 'trackers', :content => '1', :sibling => {:tag => 'required', :content => 'false'}, :sibling => {:tag => 'filter', :content => 'true'}}}}}
  end

  def test_all_empty_is_valid
    CustomField.delete_all

    get :all
    assert_response :success
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'customFields'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'customFields'

    assert_tag :tag => 'customfields', :children => {:count => 0}
  end
end
