require File.dirname(__FILE__) + '/../../../lib/mylyn_connector'

class MylynConnector::ActivitiesController < ApplicationController
  unloadable
  include MylynConnector::Rescue::ClassMethods
  include MylynConnector::Version::ClassMethods

  skip_before_filter :verify_authenticity_token

  def all
    #since 0.9 IssuePriority exists
    #TODO Is this perhabs project specific???
    @activities = is09? ? TimeEntryActivity.shared.active : Enumeration::get_values('ACTI');

    respond_to do |format|
      format.xml {render :xml => @activities, :template => 'mylyn_connector/activities/all.rxml'}
    end
  end

end
