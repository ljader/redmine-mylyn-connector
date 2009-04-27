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
    assert_template 'all.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'priorities'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'priorities'

    assert_tag :tag => 'priorities', :children => {:count => 5}

  end
end
