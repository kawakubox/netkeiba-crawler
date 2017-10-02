# frozen_string_literal: true

namespace :schedule do
  desc '指定した月の開催日を取得する (ex) 201709'
  task :collect, %i[month] => :environment do |task, args|
    month = args[:month]
    Rails.logger.info("#{month}の開催日を取得します")
    ScrapeScheduleJob.perform_now(month)
    Rails.logger.info("#{month}の開催日を取得しました")
  end
end
