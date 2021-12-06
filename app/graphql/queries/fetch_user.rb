module Queries
  class FetchUser < Queries::BaseQuery
    type Types::UserType, null: false
    argument :id, ID, required: false

    def resolve(id:)
      user = User.find_by(id: id)
      raise GraphQL::ExecutionError.new('User does not exist.') unless user

      user
    end
  end
end