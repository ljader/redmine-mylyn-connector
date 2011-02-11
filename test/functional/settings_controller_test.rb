require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::SettingsControllerTest < MylynConnector::ControllerTest
  fixtures :settings

  def setup
    super
    @controller = MylynConnector::SettingsController.new
  end

  def test_all
    get :all
    assert_response :success
    assert_template 'all.xml.builder'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'settings'
    valid = xmldoc.validate_schema schema
    assert valid , 'Ergebnis passt nicht zum Schema ' + 'settings'

    assert_tag :tag => 'useissuedoneratio', :content => 'true', :parent => {:tag => 'settings', :attributes => {:api => /^2.7.1/}}
    assert_tag :tag => 'maxperpage', :content => '100', :parent => {:tag => 'settings', :attributes => {:api => /^2.7.1/}}

  end

end
