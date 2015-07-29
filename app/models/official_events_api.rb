require 'active_resource'

#
# As the Official Events API does not confirm to RESTful specifications we have to fake the functionality to allow us
# to get the benefits we expect from an AR model.
#
# NOTE: Save resources with these classes at your own risk
#
class OfficialEventsApi < ActiveResource::Base
  def self.all(options={})
    find_every(options)
  end

  def self.find(id)
    all.find { |i| i.id == id.to_s }
  end

  def self.first
    all.first
  end

  def self.last
    all.last
  end
end
