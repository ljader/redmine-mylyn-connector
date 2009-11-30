require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::PrioritiesController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token

  def all
    begin
      #since 0.9 IssuePriority exists
      @priorities = IssuePriority.all
    rescue
      @priorities = Enumeration::get_values('IPRI');
    end

    respond_to do |format|
      format.xml {render :xml => @priorities, :template => 'mylyn_connector/priorities/all.rxml'}
    end
  end

end
