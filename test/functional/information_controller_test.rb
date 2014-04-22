require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::InformationControllerTest < MylynConnector::ControllerTest

    def setup
      super
      @controller = MylynConnector::InformationController.new
    end

  def test_version
    get :version, :format => 'xml'
    assert_response :success
    assert_template 'mylyn_connector/information/version'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'information'

    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'version'

  end

end
