class Photo < ApplicationRecord
  belongs_to :photoable, polymorphic: true
end
