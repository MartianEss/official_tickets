class Event < ActiveRecord::Base
  belongs_to :event_manager

  before_save :needs_reapproval, unless: -> { self.new_record? }

  def time_to=(time)
    super time.change(sec: 0)
  end

  def time_from=(time)
    super time.change(sec: 0)
  end

  def unapproved?
    !approved
  end

  protected

  def needs_reapproval
    self.approved = false if approved? and requires_reverificaiton
    nil
  end

  def requires_reverificaiton
    found = needed_to_be_reverification.select {|attr| self.changed.include?(attr) }
    found.present?
  end

  def needed_to_be_reverification
    %w{location date_from date_to time_to time_from}
  end
end
