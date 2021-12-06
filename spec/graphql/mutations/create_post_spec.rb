require 'rails_helper'

module Mutations
    RSpec.describe CreatePost, type: :request do
      describe '.resolve' do
        it 'creates a post' do
          author = create(:user)

          expect do
            post '/graphql', params: { query: query(user_id: author.id) }
          end.to change { Post.count }.by(1)
        end

        it 'returns a post' do
          user = create(:user)

          post '/graphql', params: { query: query(user_id: user.id) }
          json = JSON.parse(response.body)
          data = json.dig('data',  'createPost', 'post')

          expect(data['id']).to_not be_nil
          expect(data['title']).to eql "Tripwire"
        end
      end

      def query(user_id:)
        <<~GQL
          mutation {
            createPost(input: {
              userId: #{user_id} 
              title: "Tripwire"
              body: "1999"
            }) {
              post{
                id
                title
                body
              }
            }
          }
        GQL
      end
    end
end