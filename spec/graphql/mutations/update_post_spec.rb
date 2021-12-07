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

 let(:user) { create(:user) }

 let(:post) { create(:post, user_id: user.id) }

 context "when a post is updated"  do
  it "is expected to update the post" do
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: post.id}).as_json
    data = result.dig('data',  'updatePost', 'post')
    expect(data['id']).to_not be_nil
    expect(data['title']).to eql 'title'
    expect(data['body']).to eql 'body'
  end
 end

 context "when post is not present" do 
  it "it expected to raise error post not found" do
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: 1}).as_json
    data = result.dig('errors')
    expect(data[0]["message"]).to eql "Post not found."
  end

 end
end