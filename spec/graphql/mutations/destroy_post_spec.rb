require 'rails_helper'

describe ".resolve" do
 let(:mutation) do
    <<~GQL
        mutation destroyPost($id: ID){
            destroyPost (input: {id: $id}){ id }      
          }
    GQL
 end
 context "destroy a post"  do
  it "result can not blank" do
      user = create(:user)
      post = create(:post, user: user)
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: post.id}).as_json
      data = result.dig('data',  'destroyPost')
      expect(data['id']).to_not be_nil
  end
 end

 context "return correct errors" do 
  it "should raise error when user id is not correct" do
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: 1}).as_json
    data = result.dig('errors')
    expect(data[0]["message"]).to eql "Post not found."
  end

 end
end