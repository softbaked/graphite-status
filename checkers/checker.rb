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

    def previous_range
      case Time.now.hour
      when 8..21
        5
      when 22..24
        10
      when 1..7
        60
      end
    end
  end
end
