module MylynConnector

  module Rescue

    def self.included(klass)
      klass.send(:extend, MylynConnector::Rescue::Methods)
      klass.send(:include, MylynConnector::Rescue::Methods)
    end

    module Methods

      def rescue_action_locally(exception)
        rescue_action_in_public exception
      end

      def rescue_action_in_public(exception)
        @template.instance_variable_set("@exception", exception)
        response.content_type = Mime::XML
        render :status => 500, :file => File.dirname(__FILE__) + "/../../app/views/mylyn_connector/500.xml.builder"
        response.headers['Status'] = "500 " + exception.message
      end

    end

  end

end

