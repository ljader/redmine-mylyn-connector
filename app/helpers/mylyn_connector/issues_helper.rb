
module MylynConnector::IssuesHelper
  def available_status issue
    status = issue.new_statuses_allowed_to(User.current)
    if !status.include?(issue.status)
      status.unshift(issue.status);
    end
    status.compact!
    return status
  end

  def journals issue
    issue.journals.find(:all, :conditions => ["notes IS NOT NULL"])
  end

  def list_status availableStatus
    availableStatus.collect! { |i| i.id.to_s + " "}
    availableStatus.to_s.strip
  end


end
