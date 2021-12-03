module Queries
  class FetchMypost < Queries::BaseQuery
    type [Types::PostType], null: false
    argument :id, ID, required: true

    def resolve(id:)
      user = User.find(id)
      user.posts
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('User does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end