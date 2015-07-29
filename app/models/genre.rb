require 'active_resource'

class Genre < OfficialEventsApi
  self.site = 'http://officialeventsapp.com/oeadminpanel/services/'
  self.element_name = 'genre'
  
  def self.collection_path(prefix_options = {}, query_options = nil)
    '/oeadminpanel/services/genres'
  end
end
