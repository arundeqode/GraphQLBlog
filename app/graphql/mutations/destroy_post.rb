module Mutations
  class DestroyPost < BaseMutation
    # Define what type of value to be returned
    field :id, ID, null: false

    # Define what argument this mutation accepts
    argument :id, ID, required: true    # Here we use input objects for practice, Explain soon!

    def resolve(id:)
      post = Post.find_by(id: id)
      raise GraphQL::ExecutionError.new('Post not found.') unless post
      
      { id: id } if post.destroy

      raise GraphQL::ExecutionError.new(post.errors.full_messages.join(', '))
    end
  end
end
