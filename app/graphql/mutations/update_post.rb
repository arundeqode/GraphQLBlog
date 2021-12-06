module Mutations
  class UpdatePost < BaseMutation
    # Define what type of value to be returned
    field :post, Types::PostType, null: false

    # Define what argument this mutation accepts
    argument :id, ID, required: false    # Here we use input objects for practice, Explain soon!
    argument :title, String, required: true
    argument :body, String, required: true

    def resolve(id:, title:, body:)
      post = Post.find_by(id: id)
      raise GraphQL::ExecutionError.new('Post not found.') unless post

      return { post: post } if post.update!(title: title, body: body)

      raise GraphQL::ExecutionError.new(post.errors.full_messages.join(', '))
    end
  end
end
