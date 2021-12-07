require 'rails_helper'

describe ".resolve" do
 let(:query) do
    <<~GQL
        query {
            posts {
                id
                title
                body
            }      
          }
    GQL
 end

 let(:user) { create(:user) }

 let(:post) { create(:post, user_id: user.id) }

 let(:post1) { create(:post, body: "body 1",user_id: user.id) }

 context "when fetch posts"  do
  it "is expected to return all posts" do
    result = RailsApiGraphqlCrudTutoSchema.execute(query).as_json
    data = result.dig('data',  'posts')
    expect(data.count).to eql Post.count
  end
 end

end