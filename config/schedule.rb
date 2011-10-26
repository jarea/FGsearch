every 1.day, :at => '3:00 am' do 
  rake "cron:remove:all"
end
