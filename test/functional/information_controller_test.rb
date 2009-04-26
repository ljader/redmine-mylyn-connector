require File.dirname(__FILE__) + '/../test_helper'

class MylynConnector::InformationControllerTest < MylynConnector::ControllerTest

    def setup
      super
      @controller = MylynConnector::InformationController.new
    end

  def test_version
    get :version
    assert_response :success
    assert_template 'version.rxml'

    xmldoc = XML::Document.string @response.body
    schema = read_schema 'version'

    valid = xmldoc.validate_schema schema
    assert valid , 'Ergenis passt nicht zum Schema ' + 'version'

  end

end
