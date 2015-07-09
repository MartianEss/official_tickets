class Event < ActiveRecord::Base
  belongs_to :event_manager

  has_many :orders

  before_save :set_approval_status, unless: -> { self.new_record? }

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
    %w{location date_from date_to time_to time_from}
  end
end
