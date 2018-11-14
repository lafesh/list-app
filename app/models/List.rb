class List < ActiveRecord::Base
    belongs_to :user
    validates :list_title, :list_item, presence: true
end