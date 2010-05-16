xml.instruct! :xml, :encoding => "UTF-8"
xml.users :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  @users.each do |user|
    xml.user :id => user.id do
      xml.name user.name
      xml.login user.login
      xml.firstname user.firstname
      xml.lastname user.lastname
      xml.mail user.mail
    end
  end
end
