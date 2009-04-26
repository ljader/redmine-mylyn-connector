require 'rubygems'
require 'xml'

module MylynConnector
  class ControllerTest < ActionController::TestCase

    def setup
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
    end

    protected
    def read_schema name
      schemapath = File.dirname(__FILE__) + '/../../test/schema/' + name + '.xsd';
      schemadoc = XML::Document.file schemapath
      XML::Schema.document schemadoc
    end

  end
end
