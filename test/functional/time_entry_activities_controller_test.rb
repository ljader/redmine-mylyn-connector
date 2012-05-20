require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::ActivitiesControllerTest < MylynConnector::ControllerTest
  fixtures :enumerations
  

  def setup
    super
    @controller = MylynConnector::TimeEntryActivitiesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/time_entry_activities/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'timeEntryActivities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'timeEntryActivities'

    acts =  {:tag => 'timeentryactivities', :children => {:count => 3}, :attributes => {:api => cr}}
    act = {:tag => 'timeentryactivity', :attributes => {:id => 10}, :parent => acts}
    assert_tag :tag => 'name', :content => 'Development', :parent => act
    assert_tag :tag => 'position', :content => '2', :parent => act
    assert_tag :tag => 'isdefault', :content => 'true', :parent => act
    
  end
end
