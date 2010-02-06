require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::PrioritiesController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods
  include MylynConnector::Version::ClassMethods

  skip_before_filter :verify_authenticity_token

  def all
    #since 0.9 IssuePriority exists
    @priorities  = is09? ? IssuePriority.all : Enumeration::get_values('IPRI');

    respond_to do |format|
      format.xml {render :xml => @priorities, :template => 'mylyn_connector/priorities/all.rxml'}
    end
  end

end
