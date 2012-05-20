require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::TrackersControllerTest < MylynConnector::ControllerTest
  fixtures :trackers, :custom_fields, :custom_fields_trackers

  def setup
    super
    @controller = MylynConnector::TrackersController.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/trackers/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'trackers'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'trackers'

    trs =  {:tag => 'trackers', :children => {:count => 3}, :attributes => {:api => cr}}
    tr = {:tag => 'tracker', :attributes => {:id => 3}, :parent => trs}
    assert_tag :tag => 'name', :content => 'Support request', :parent => tr
    assert_tag :tag => 'position', :content => '3', :parent => tr
    assert_tag :tag => 'issuecustomfields', :content=> '2 6', :parent => tr

  end

  def test_all_empty_is_valid
    Tracker.delete_all
 
    get :all, :format => 'xml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'trackers'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'trackers'

    assert_tag :tag => 'trackers', :children => {:count => 0}, :attributes => {:api => cr}
  end
end
