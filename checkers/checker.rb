module Checkers
  module Checker

    def is_more_than_threshold(threshold_value, data_points)
      points = reformat_data(data_points)
      points.all? { |p| p >= threshold_value }
    end

    def is_less_than_threshold(threshold_value, data_points)
      points = reformat_data(data_points)
      points.all? { |p| p <= threshold_value }
    end

    def is_growth(threshold_value, data_points)
      points = reformat_data(data_points)
      (points.last - points.first) >= threshold_value
    end

    def is_dead(data_points)
      points = reformat_data(data_points)
      points.all?(&:zero?)
    end

    def reformat_data(data_points)
      data_points.map { |data_point| data_point.first || 0 }
    end

    def previous_range(time_ranges)
      case Time.now.hour
      when 9..21
        time_ranges['morning']
      when 22..24
        time_ranges['before_midnight']
      when 1..7
        time_ranges['midnight']
      end
    end
  end
end
