# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  if ENV['FB_METRICS']
    factory_bot_metrics = {}

    config.before(:suite) do
      ActiveSupport::Notifications
        .subscribe('factory_bot.run_factory') do |_name, start, finish, _id, payload|
        factory_name = payload[:name]

        factory_bot_metrics[factory_name] ||= { calls: 0, times: 0.0 }
        factory_bot_metrics[factory_name][:calls] += 1
        factory_bot_metrics[factory_name][:times] += (finish - start)
      end
    end

    config.after(:suite) do
      calls = factory_bot_metrics.values.sum { _1[:calls] }
      times = factory_bot_metrics.values.sum { _1[:times] }.round(1)

      puts "\n\nFactoryBot metrics: number of calls #{calls}, time spend #{times}s"
    end
  end
end
