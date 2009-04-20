require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::PrioritiesController < ApplicationController
  unloadable

  def all
    @priorities = Enumeration::get_values('IPRI')

    respond_to do |format|
      format.xml {render :xml => @priorities, :template => 'mylyn_connector/priorities/all.rxml'}
    end
  end

end
