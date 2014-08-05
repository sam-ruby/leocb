class Person < ActiveRecord::Base
  belongs_to :company
  self.table_name = :persons
end
