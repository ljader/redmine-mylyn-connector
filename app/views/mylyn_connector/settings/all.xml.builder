xml.instruct! :xml, :encoding => "UTF-8"
xml.settings :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  xml.useIssueDoneRatio Setting.issue_done_ratio != 'issue_status'
end
