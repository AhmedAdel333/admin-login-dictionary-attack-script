require "mechanize"


print "Enter the login page link: "
login_page_link = gets.chomp
USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36"
mechanize_agent = Mechanize.new do |agent|
  agent.user_agent = USER_AGENT
end

form_page = mechanize_agent.get(login_page_link)
form_details = form_page.form()
data = pp form_details
puts data