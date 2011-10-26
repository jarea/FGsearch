class Video::Topic < ActiveRecord::Base
    set_table_name "name"
    establish_connection :fg_video  
end
