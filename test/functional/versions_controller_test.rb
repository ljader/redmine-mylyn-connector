require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::VersionsControllerTest < MylynConnector::ControllerTest
  fixtures :versions

  def setup
    super
    @controller = MylynConnector::VersionsController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.xml.builder'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'versions'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'versions'

    vers =  {:tag => 'versions', :children => {:count => 7}, :attributes => {:api => cr}}
    ver = {:tag => 'version', :attributes => {:id => 4}, :parent => vers}
    assert_tag :tag => 'name', :content => '2.0', :parent => ver
    assert_tag :tag => 'status', :content => 'open', :parent => ver

  end

  def test_all_empty_is_valid
    Version.delete_all
 
    get :all

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'versions'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'versions'

    puts @response.body
    assert_tag :tag => 'versions', :children => {:count => 0}, :attributes => {:api => cr}
  end
end
