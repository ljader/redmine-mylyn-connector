require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::ActivitiesControllerTest < MylynConnector::ControllerTest
  fixtures :enumerations

  def setup
    super
    @controller = MylynConnector::ActivitiesController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.xml.builder'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'timeEntryActivities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'activities'

    acts =  {:tag => 'activities', :children => {:count => 3}, :attributes => {:api => /^2.7.0/}}
    act = {:tag => 'activity', :attributes => {:id => 10}, :parent => acts}
    assert_tag :tag => 'name', :content => 'Development', :parent => act
    assert_tag :tag => 'position', :content => '2', :parent => act
    assert_tag :tag => 'default', :content => 'true', :parent => act
    
  end
end
