class ScheduledPickup < ActiveRecord::Base
  HOURS_IN_ADVANCE_FOR_CONFIRMATION = 48

  belongs_to :zone, touch: true

  has_many :donations, dependent: :destroy

  validates :zone, presence: true
  validates :end_at, presence: true
  validates :start_at, presence: true

  delegate :zipcode, to: :zone

  def self.current
    where("start_at >= ?", Time.current.beginning_of_day)
  end

  def time_range
    TimeRange.new(start_at: start_at, end_at: end_at)
  end

  def confirmation_requested_at
    start_at - HOURS_IN_ADVANCE_FOR_CONFIRMATION.hours
  end

  def users
    []
  end
end
