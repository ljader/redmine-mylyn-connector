xml.instruct! :xml, :encoding => "UTF-8"
xml.settings root_attribs do
  xml.useIssueDoneRatio Setting.issue_done_ratio != 'issue_status'
  xml.maxPerPage Setting.per_page_options_array.max
end
