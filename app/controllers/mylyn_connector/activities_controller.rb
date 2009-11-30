require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::ActivitiesController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods

  skip_before_filter :verify_authenticity_token

  def all
    begin
      #since 0.9 IssuePriority exists
      @activities = TimeEntryActivity.all
    rescue
      @activities = Enumeration::get_values('ACTI');
    end

    respond_to do |format|
      format.xml {render :xml => @activities, :template => 'mylyn_connector/activities/all.rxml'}
    end
  end

end
