require 'rubygems' 
require 'xml'

module MylynConnector
  class ControllerTest < ActionController::TestCase
    
    def self.fixtures(*table_names)
      dir = File.join(File.dirname(__FILE__), "../../test/fixtures/" + self.rr )

      table_names.each{|x|
        ActiveRecord::Fixtures.create_fixtures(dir, x) if File.exist?(dir + "/" + x.to_s + ".yml")
      }

      super(table_names)
    end

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

    def self.rr
      MylynConnector::Version.redmine_release
    end

    def cr
      MylynConnector::Version.to_s
    end

  end
end
