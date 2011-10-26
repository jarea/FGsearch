class FgBeautynews < ActiveRecord::Base
    establish_connection :fg_beautynews
    set_table_name "Forum_Topic"
    belongs_to :fbc , :class_name => "FgBeautynewsCate",:foreign_key =>"ftc_rid"
end



