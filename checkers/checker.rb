module Checkers
  module Checker

    def is_more_than_threshold(threshold_value, data_points)
      points = reformat_data(data_points)
      status = false

      points.each do |data_point|
        if data_point >= threshold_value
          status = true
          break
        end
      end
      status
    end

    def is_less_than_threshold(threshold_value, data_points)
      points = reformat_data(data_points)
      status = false

      points.each do |data_point|
        if data_point <= threshold_value
          status = true
          break
        end
      end
      status
    end

    def is_dead(data_points)
      points = reformat_data(data_points)
      points.inject(0){|sum,x| sum + x } == 0
    end

    def reformat_data(data_points)
      data_points.map { |data_point| data_point[0] ? data_point[0] : 0 }
    end

    def previous_range
      case Time.now.hour
      when 6..23
        5
      when 24..1
        10
      when 2..5
        60
      end
    end
  end
end