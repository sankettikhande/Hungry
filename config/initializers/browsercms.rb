Cms.attachment_file_permission = 0640
#Cms.table_prefix = "cms_"

# Cms::DomainSupport.class_eval do
#   def cms_site?
#     true && current_user.able_to?(:administrate, :edit_content, :publish_content)
#   end
# end

TIME_ARR = ["12:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM",
	"05:00 AM", "06:00 AM", "07:00 AM", "08:00 AM", "09:00 AM", "10:00 AM", 
	"11:00 AM", "12:00 PM", "01:00 PM", "02:00 PM", "03:00 PM", "04:00 PM", 
	"04:30 PM", "05:00 PM", "06:00 PM", "07:00 PM", "08:00 PM", "09:00 PM", 
	"10:00 PM", "11:00 PM", "11:30 PM", "11:59 PM"]

TIME_SLOTS = [" 8AM - 9AM", " 9AM - 10AM", "10AM - 11AM", "12PM - 1PM", " 1PM - 2PM", " 2PM - 3PM", " 3PM - 4PM", " 4PM - 5PM", 
	" 5PM - 6PM", " 8PM - 9PM", " 9PM - 10PM", "10PM - 11PM"]
	
TIME = {'12AM' => 0, ' 1AM' => 1, ' 2AM' => 2, ' 3AM' => 3, ' 4AM' => 4, ' 5AM' => 5, 
	' 6AM' => 6, ' 7AM' => 7, ' 8AM' => 8, ' 9AM' => 9, '10AM' => 10, '11AM' => 11, 
	'12PM' => 12, ' 1PM' => 13, ' 2PM' => 14, ' 3PM' => 15, ' 4PM' => 16, ' 5PM' => 17, 
	' 6PM' => 18, ' 7PM' => 19, ' 8PM' => 20, ' 9PM' => 21, '10PM' => 22, '11PM' => 23}	