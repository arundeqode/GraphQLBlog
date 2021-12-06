module Mutations
  class CreateUser < BaseMutation
    # Define what type of value to be returned
    field :user, Types::UserType, null: false

    # Define what argument this mutation accepts
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    # argument :user_id, Integer, required: true

    def resolve(name:, email:, password:)
      user = User.new(name: name, email: email, password: password)
      return { user: user } if user.save
      
      raise GraphQL::ExecutionError.new(user.errors.full_messages.join(', '))
    end
  end
end
