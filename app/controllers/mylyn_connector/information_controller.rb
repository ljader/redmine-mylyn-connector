require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::InformationController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token
  
  def version
    @data = MylynConnector::Version.to_a

    respond_to do |format|
      format.xml {render :xml => @data, :template => 'mylyn_connector/information/version.rxml'}
    end
  end
end
