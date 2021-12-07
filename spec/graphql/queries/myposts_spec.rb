require 'rails_helper'

describe ".resolve" do
 let(:query) do
    <<~GQL
        query($id: ID) {
            myPosts(id: $id) {
                id
                title
                body
            }      
          }
    GQL
 end

 let(:user) { create(:user) }

 let(:post) { create(:post, user_id: user.id) }

 context "when fetch my posts"  do
  it "is expected to return all posts" do
    result = RailsApiGraphqlCrudTutoSchema.execute(query, variables: {id: user.id}).as_json
    data = result.dig('data',  'myPosts')
    expect(data.count).to eql user.posts.count
  end
 end

 context "when user is not present" do 
  it "is expected to raise error user does not exist" do
    result = RailsApiGraphqlCrudTutoSchema.execute(query, variables: {id: nil}).as_json
    data = result.dig('errors')
    expect(data[0]["message"]).to eql "User does not exist."
  end
 end

end