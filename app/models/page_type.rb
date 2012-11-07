class PageType < ActiveRecord::Base
    # Attributes
    #-----------
    attr_accessible :name, :is_mandatory, :type
end
