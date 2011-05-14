module MylynConnector

  module Hooks

    class ControllerIssuesEditAfterSaveHook < Redmine::Hook::Listener

      def controller_issues_edit_after_save(context={})

        if context[:issue] && context[:params][:issue] && context[:params][:issue][:watcher_user_ids]

          issue = context[:issue]
          watcheruserids = context[:params][:issue][:watcher_user_ids]

          if User.current.allowed_to?(:delete_issue_watchers, issue.project)
            issue.watchers.each { |w|
              issue.remove_watcher(User.find(w.user.id)) unless watcheruserids.include?(w.user.id)
            }
          end

          if User.current.allowed_to?(:add_issue_watchers, issue.project)
            watcheruserids.each { |id|
              user = User.find(id)
              issue.add_watcher(user) unless issue.watched_by?(user)
            }
          end

        end

      end

    end

  end

end