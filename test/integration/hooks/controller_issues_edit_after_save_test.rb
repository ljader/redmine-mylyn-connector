require File.dirname(__FILE__) + '/../../test_helper'

class MylynConnector::Hooks::ControllerIssuesEditAfterSaveTest < MylynConnector::Test::IntegrationTest

  self.use_transactional_fixtures = true

  fixtures :users, :roles, :members, :issue_categories, :trackers, :versions, :queries, :projects, :projects_trackers, :custom_fields_trackers, :issues, :journals, :attachments, :custom_fields, :custom_values, :watchers, :time_entries

  include Redmine::Hook::Helper

  context "#controller_issues_edit_before_save" do

    setup do
      Setting.rest_api_enabled = '1'
    end

    context "modifing watchers" do

      setup do
        @headers = {:authorization => credentials('jsmith') }
      end

      should "add two new watchers and ignore one existing" do
        issue_id = 3;

        assert_difference('Watcher.count', 2) do
          put "/issues/" + issue_id.to_s + ".xml", {:issue => {:watcher_user_ids => [1, 2, 3] }}, @headers
        end

        assert_not_nil(Watcher.find(:first, :conditions => ["watchable_type='Issue' AND watchable_id=? AND user_id=?", issue_id, 1]))
        assert_not_nil(Watcher.find(:first, :conditions => ["watchable_type='Issue' AND watchable_id=? AND user_id=?", issue_id, 3]))
      end

      should "add one new watcher and remove one existing" do
        issue_id = 3;

        assert_difference('Watcher.count', 1) do
          put "/issues/" + issue_id.to_s + ".xml", {:issue => {:watcher_user_ids => [1, 3] }}, @headers
        end

        assert_not_nil(Watcher.find(:first, :conditions => ["watchable_type='Issue' AND watchable_id=? AND user_id=?", issue_id, 1]))
        assert_not_nil(Watcher.find(:first, :conditions => ["watchable_type='Issue' AND watchable_id=? AND user_id=?", issue_id, 3]))
        assert_nil(Watcher.find(:first, :conditions => ["watchable_type='Issue' AND watchable_id=? AND user_id=?", issue_id, 2]))
      end

      should "do nothing - insufficient data" do

        assert_difference('Watcher.count', 0) do
          put "/issues/3.xml", {}, @headers
        end

        assert_difference('Watcher.count', 0) do
          put "/issues/3.xml", {:issue => {}}, @headers
        end

      end

    end

  end

  def credentials(user, password=nil)
    ActionController::HttpAuthentication::Basic.encode_credentials(user, password || user)
  end

end
