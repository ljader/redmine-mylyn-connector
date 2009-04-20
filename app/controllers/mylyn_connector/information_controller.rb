require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::InformationController < ApplicationController
  unloadable
  
  def version
    @data = MylynConnector::Version.to_a

    respond_to do |format|
      format.xml {render :xml => @data, :template => 'mylyn_connector/information/version.rxml'}
    end
  end
end
