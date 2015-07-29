class DressCode < OfficialEventsApi
  self.site = 'http://officialeventsapp.com/oeadminpanel/services/'
  self.element_name = 'dress_code'
  
  def self.collection_path(prefix_options = {}, query_options = nil)
    '/oeadminpanel/services/dresscodes'
  end
end

