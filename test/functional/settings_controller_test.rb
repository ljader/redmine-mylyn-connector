require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::SettingsControllerTest < MylynConnector::ControllerTest
  fixtures :users

  def setup
    super
    @controller = MylynConnector::SettingsController.new
  end

  def test_all
    get :all, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/settings/all'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'settings'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'settings'

    assert_tag :tag => 'useissuedoneratio', :content => 'true', :parent => {:tag => 'settings', :attributes => {:api => cr}}
    assert_tag :tag => 'maxperpage', :content => '100', :parent => {:tag => 'settings', :attributes => {:api => cr}}

  end

end
