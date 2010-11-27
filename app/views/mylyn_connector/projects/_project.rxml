xml.project(:id => project.id, :newIssueAllowed => new_issue_allowed?(project), :moveIssueAllowed => move_issue_allowed?(project)) do
  xml.name project.name
  xml.identifier project.identifier

  xml.trackers integer_list(get_trackers(project))
  xml.versions integer_list(get_versions(project))

  xml.members do
    get_members(project).each do |member|
      xml.member(:userId => member.user.id, :assignable => member_assignable?(member) )
    end
  end

  xml.issueCategories integer_list(get_issue_categories(project))

  xml.issueCustomFields do
    get_trackers(project).each do |tracker|
      cf_list = get_issue_custom_fields(project, tracker)
      xml.issueCustomFieldsByTracker({:trackerId => tracker.id}, integer_list(cf_list)) unless cf_list.empty?
    end
  end

  xml.timeEntryActivities do
    project.activities.each do |activity|
      xml.timeEntryActivity :id => activity.id do
        xml.name activity.name
        xml.position  activity.position
        xml.isDefault  activity.is_default
      end
    end
  end

  
end
