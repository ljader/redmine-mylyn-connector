xml.instruct! :xml, :encoding => "UTF-8"
xml.error :xmlns => 'http://redmin-mylyncon.sf.net/schemas/WS-API-2.6', :status => 500 do
  xml.message @exception.message if @exception
  xml.backtrace @exception.backtrace if @exception
end
