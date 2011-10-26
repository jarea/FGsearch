class FgBeautynewsCate < ActiveRecord::Base

       establish_connection :fg_beautynews
       set_table_name "Forum_Topic_Cate"
       has_many :fb,  :class_name => "FgBeautynews",:foreign_key => "ft_ftc_rid"
end
