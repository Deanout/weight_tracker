module Weightable
  extend ActiveSupport::Concern

  included do
    before_action :set_default_unit
  end

  private

  def date_range
    case params[:time_frame]
    when '7_days'
      7.days.ago.beginning_of_day..Date.current.end_of_day
    when '30_days'
      30.days.ago.beginning_of_day..Date.current.end_of_day
    when '90_days'
      90.days.ago.beginning_of_day..Date.current.end_of_day
    when 'last_year'
      1.year.ago.beginning_of_day..Date.current.end_of_day
    else
      # All time weights
      Weight.minimum(:date)..Date.current.end_of_day
    end
  end

  def set_default_unit
    @default_unit = cookies[:preferred_unit] || 'kg'
  end
end
