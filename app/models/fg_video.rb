class FgVideo < ActiveRecord::Base
    establish_connection :fg_video
    set_table_name "topic" 
end
