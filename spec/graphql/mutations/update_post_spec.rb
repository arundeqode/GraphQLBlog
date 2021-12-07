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

 let(:result) do
    user = create(:user)
    post = create(:post, user: user)
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {id: post.id}).as_json
 end

 context "when update a post"  do
  it "is expect to not nil" do
    data = result.dig('data',  'updatePost', 'post')
    expect(data['id']).to_not be_nil
  end

  it "is expect to update title" do
    title = result.dig('data',  'updatePost', 'post', 'title')
    expect(title).to eql 'title'
  end

  it "is expect to update body" do
    body = result.dig('data',  'updatePost', 'post', 'body')
    expect(body).to eql 'body'
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