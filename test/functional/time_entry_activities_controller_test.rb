require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::ActivitiesControllerTest < MylynConnector::ControllerTest
  fixtures :enumerations

  def setup
    super
    @controller = MylynConnector::TimeEntryActivitiesController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.xml.builder'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'timeEntryActivities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'timeEntryActivities'

    acts =  {:tag => 'timeentryactivities', :children => {:count => 3}, :attributes => {:api => /^2.7.1/}}
    act = {:tag => 'timeentryactivity', :attributes => {:id => 10}, :parent => acts}
    assert_tag :tag => 'name', :content => 'Development', :parent => act
    assert_tag :tag => 'position', :content => '2', :parent => act
    assert_tag :tag => 'isdefault', :content => 'true', :parent => act
    
  end
end
