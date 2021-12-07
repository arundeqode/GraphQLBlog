require 'rails_helper'

describe ".resolve" do
 let(:mutation) do
    <<~GQL
        mutation destroyPost($id: ID){
            destroyPost (input: {id: $id}){ id }      
          }
    GQL
 end

 let(:result) do
    user = create(:user)
    post = create(:post, user_id: user.id)
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: post.id}).as_json
 end

 context "when destroy a post"  do
  it "is expect to not nil" do
      data = result.dig('data',  'destroyPost')
      expect(data['id']).to_not be_nil
  end
 end

 context "when error occurs" do 
  it "it expect to raise error when post is not present" do
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: 1}).as_json
    data = result.dig('errors')
    expect(data[0]["message"]).to eql "Post not found."
  end
 end
end