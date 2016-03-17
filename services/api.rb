class GraphiteNoti < Sinatra::Base

  get '/' do
    settings.config_alert.alerts.each do |alert|
      response    = HTTParty.get("#{settings.config_alert.graphite_url}/render?format=json#{alert.query}&from=-#{previous_range(alert.time_ranges)}min&until=now")
      is_abnormal = false

      response.each do |data|
        if data['datapoints'].nil?
          p "#{alert.query}" # Debugging
          is_abnormal = true
        else
          is_abnormal = case alert.check_type
          when 'is_more_than'
            is_more_than_threshold(alert.threshold_value, data['datapoints'])
          when 'is_less_than'
            is_regression_threshold(alert.threshold_value, data['datapoints'])
          when 'is_growth'
            is_growth(alert.threshold_value, data['datapoints'])
          when 'is_dead'
            is_dead(data['datapoints'])
          end
        end

        if is_abnormal
          p "Please check #{data['target']} : #{alert.check_type} #{alert.threshold_value}"
          halt 500, "Please check #{data['target']} : #{alert.check_type} #{alert.threshold_value}"
          break
        end
      end
    end
    "OK"
  end

end
