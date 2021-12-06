module Mutations
  class CreatePost < BaseMutation
    # Define what type of value to be returned
    field :post, Types::PostType, null: false

    # Define what argument this mutation accepts
    argument :title, String, required: true
    argument :body, String, required: true
    argument :user_id, Integer, required: true

    def resolve(title:, body:, user_id:)
      # we will use current_user in future
      user = User.find_by(id: user_id)
      raise GraphQL::ExecutionError.new("user not found") unless user

      post = user.posts.new(title: title, body: body)
      return { post: post } if post.save
      
      raise GraphQL::ExecutionError.new(post.errors.full_messages.join(', '))
    end
  end
end
