
module MylynConnector::WatchersHelper
  def watched?(issue)
    return false unless User.current.logged?
    return issue.watched_by?(User.current)
  end


  def watchers(issue)
    issue.watcher_users.collect {|u| u.id }.join(" ")
  end

end
