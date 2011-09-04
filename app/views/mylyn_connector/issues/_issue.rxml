xml.issue({:id => issue.id, :editAllowed => edit_allowed?(issue)}.merge(attr||={}) ) do

  #Ticket
  xml.subject issue.subject
  xml.description issue.description
  xml.createdOn issue.created_on.xmlschema, :unixtime => issue.created_on.to_i
  xml.updatedOn issue.updated_on.xmlschema, :unixtime => issue.updated_on.to_i

  #References
  xml.trackerId issue.tracker_id
  xml.projectId issue.project_id
  xml.statusId issue.status_id
  xml.priorityId issue.priority_id

  #Watchers
  xml.watched watched?(issue)
  showWatchers = watchers_view_allowed?(issue)
  if (showWatchers && issue.watcher_users)
    xml.watchers integer_list(issue.watcher_users), :viewAllowed => showWatchers, :addAllowed => watchers_add_allowed?(issue), :deleteAllowed => watchers_delete_allowed?(issue)
  else
    xml.watchers :viewAllowed => showWatchers, :addAllowed => watchers_add_allowed?(issue), :deleteAllowed => watchers_delete_allowed?(issue)
  end

  #Work/Progress(optional)
  xml.startDate issue.start_date.to_s if issue.start_date
  xml.dueDate issue.due_date.to_s if issue.due_date
  xml.doneRatio issue.done_ratio
  xml.estimatedHours issue.estimated_hours if issue.estimated_hours

  #Optional References
  xml.authorId issue.author_id if issue.author_id
  xml.categoryId issue.category_id if issue.category_id
  xml.assignedToId issue.assigned_to_id if issue.assigned_to_id
  xml.fixedVersionId issue.fixed_version_id if issue.fixed_version_id
  xml.parentId issue.parent_id if issue.parent_id
  xml.subtasks integer_list(subtasks(issue)) unless issue.leaf?

  xml.availableStatus integer_list(available_status(issue))


  xml.customValues {
    issue.custom_values.each {|value|
      xml.customValue value.value, {:id=> value.id, :customFieldId => value.custom_field_id}
    }
  }
 
  xml.journals {
    journals(issue).each {|journal|
      xml.journal(:id => journal.id, :editAllowed => (journal.editable_by?(User.current) ? true : false)) do
        xml.userId journal.user_id if journal.user_id
        xml.createdOn journal.created_on.xmlschema, :unixtime => journal.created_on.to_i
        xml.notes journal.notes
      end
    }
  }

  xml.attachments {
    issue.attachments.each {|attachment|
      xml.attachment :id => attachment.id do
        xml.authorId attachment.author_id if attachment.author_id
        xml.createdOn attachment.created_on.xmlschema, :unixtime => attachment.created_on.to_i
        xml.filename attachment.filename
        xml.filesize attachment.filesize
        xml.digest attachment.digest
        xml.contentType attachment.content_type
        xml.description attachment.description
      end
    }
  }

  xml.issueRelations {
    issue.relations.each {|relation|
      xml.issueRelation :id => relation.id do
        xml.issueFromId relation.issue_from_id
        xml.issueToId relation.issue_to_id
        xml.relationType relation.relation_type
        xml.delay relation.delay if relation.delay && relation.delay >0
      end
    }
  }

  showTimeEntries = time_entries_view_allowed?(issue)
  xml.timeEntries :viewAllowed => showTimeEntries, :newAllowed => time_entries_new_allowed?(issue) do
    if showTimeEntries
      xml.sum issue.spent_hours
      issue.time_entries.each  {|entry|
        xml.timeEntry :id => entry.id, :editAllowed => entry.editable_by?(User.current)?true:false do
          xml.hours entry.hours
          xml.activityId entry.activity_id
          xml.userId entry.user_id
          xml.spentOn entry.spent_on
          xml.comments entry.comments
          xml.customValues {
            entry.custom_values.each {|value|
              xml.customValue value.value, { :id => value.id, :customFieldId => value.custom_field_id }
            }
          }
        end
      }
    end
  end

end

