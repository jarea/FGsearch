# encoding: utf-8
namespace :dev do
   task :clean => ["db:migrate"]
   
   
   task :clean_forum => ["db:migrate:down VERSION=20110927071714","db:migrate:up VERSION=20110927071714"]
        
   
   
   
end
