module Types
  class UserType < Types::BaseObject
    description "A blog post"
    field :id, ID, null: false
    field :name, String, null: false
  end
end
