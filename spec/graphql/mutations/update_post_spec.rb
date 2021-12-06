require 'rails_helper'

describe ".resolve" do
 let(:mutation) do
    <<~GQL
        mutation updatePost($id: ID){
            updatePost (input: {id: $id, title: "title", body: "body" }){
             post{
              id
              title
              body
           }          
      }      
    }
    GQL
 end
 context "update a post"  do
  it "result can not blank" do
      user = create(:user)
      post = create(:post, user: user)
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: post.id}).as_json
      data = result.dig('data',  'updatePost', 'post')
      expect(data['id']).to_not be_nil
  end

  it "result return correct data" do
      user = create(:user)
      post = create(:post, user: user)
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: post.id}).as_json
      data = result.dig('data',  'updatePost', 'post')
      expect(data).to eq({"id"=> data['id'], "title"=> "title", "body"=> "body"})
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