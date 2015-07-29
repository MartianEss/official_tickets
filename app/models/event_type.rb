class EventType < OfficialEventsApi
  self.site = 'http://officialeventsapp.com/oeadminpanel/services/'
  self.element_name = 'event_type'
  
  def self.collection_path(prefix_options = {}, query_options = nil)
    '/oeadminpanel/services/eventTypes'
  end
end

