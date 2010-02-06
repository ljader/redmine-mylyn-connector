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
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'activities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'activities'

    #0.8 3
    #0.9 4
    assert_tag :tag => 'activities', :children => {:count => 3..4}
  end
end
