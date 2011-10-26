# encoding: utf-8
namespace :cron do
  namespace :remove do
    task :all => ["blog","forum","video","product","beautynews"]
    one_day_ago = Time.now-1.day
    task :blog => :environment do
      BlogSearchKeyword.where(['created_at <= ?', one_day_ago ]).each do |k|
          puts "Destroy keyword :"+k.keyword
          k.destroy
      end
    end 
    task :forum => :environment do
      ForumSearchKeyword.where(['created_at <= ?', one_day_ago ]).each do |k|
          puts "Destroy keyword :"+k.keyword
          k.destroy
      end
    end 
    task :video => :environment do
      VideoSearchKeyword.where(['created_at <= ?', one_day_ago ]).each do |k|
          puts "Destroy keyword :"+k.keyword
          k.destroy
      end
    end 
    task :product => :environment do
      ProductSearchKeyword.where(['created_at <= ?', one_day_ago ]).each do |k|
          puts "Destroy keyword :"+k.keyword
          k.destroy
      end
    end 
    task :beautynews => :environment do
      BeautynewsSearchKeyword.where(['created_at <= ?', one_day_ago ]).each do |k|
          puts "Destroy keyword :"+k.keyword
          k.destroy
      end
    end 
  end
end
