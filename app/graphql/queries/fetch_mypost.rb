module Queries
  class FetchMypost < Queries::BaseQuery
    type [Types::PostType], null: false
    argument :id, ID, required: false

    def resolve(id:)
      user = User.find_by(id: id)
      raise GraphQL::ExecutionError.new('User does not exist.') unless user
      
      user.posts
    end
  end
end