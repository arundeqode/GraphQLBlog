require 'rails_helper'

describe ".resolve" do
 let(:mutation) do
    <<~GQL
        mutation destroyPost($id: ID){
            destroyPost (input: {id: $id}){ id }      
          }
    GQL
 end

 let(:user) { create(:user) }

 let(:post) { create(:post, user_id: user.id) }

 context "when a post is destroyed"  do
  it "is expected to destroy that post" do
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: post.id}).as_json
      data = result.dig('data',  'destroyPost')
      expect(data['id']).to_not be_nil
  end
 end

 context "when post is not present" do 
  it "is expected to raise error post not found" do
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: 1}).as_json
    data = result.dig('errors')
    expect(data[0]["message"]).to eql "Post not found."
  end
 end
end