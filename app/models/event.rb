class Event < ActiveRecord::Base
  belongs_to :event_manager

  has_many :orders
  has_many :tickets_allocations

  has_one :genre
  has_one :event_type
  has_one :dress_code

  before_save :set_approval_status, unless: -> { self.new_record? }

  validates_presence_of :title, :description, :contact_number, :date_from, :date_to, :time_from
  validates_presence_of :dress_code_id, :genre_id, :event_type_id

  validates_presence_of :venue, :address_line1, :town_city, :post_code

  scope :approved, -> { where(approved: true) }

  def event_type
    EventType.find(self.event_type_id).name
  end

  def dress_code
    DressCode.find(self.dress_code_id).name
  end

  def genre
    Genre.find(self.genre_id).name
  end

  def location
    [
      address_line1,
      address_line2,
      town_city,
      post_code
    ].compact.join(', ')
  end

  def time_to=(time)
    super time.change(sec: 0)
  end

  def time_from=(time)
    super time.change(sec: 0)
  end

  def approved?
    approved
  end

  def unapproved?
    !approved
  end

  def needs_reapproval?
    approved? and requires_reapproval
  end

  protected

  def set_approval_status
    self.approved = false if needs_reapproval?
    nil
  end

  def requires_reapproval
    found = needed_to_be_reapproval.select {|attr| self.changed.include?(attr) }
    found.present?
  end

  def needed_to_be_reapproval
    %w{town_city address_line1 address_line2 post_code date_from date_to time_to time_from}
  end
end
