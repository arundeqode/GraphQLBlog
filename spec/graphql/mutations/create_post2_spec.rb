require 'rails_helper'

describe ".resolve" do
 let(:mutation) do
    <<~GQL
        mutation createPost($userId: ID){
            createPost (input: {userId: $userId, title: "title", body: "body" }){
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
    result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
 end

 context "when create a post"  do
    it "is expect to not nil" do
      data = result.dig('data',  'createPost', 'post')
      expect(data['id']).to_not be_nil
    end
 end

 context "when error occurs" do 
    it "it expect to raise error when user is not present" do
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: 1}).as_json
      expect(result['errors'][0]["message"]).to eql "user not found"
    end

    it "it expect to raise error when create post with same body" do
      user = create(:user)
      result
      result1 = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
      expect(result1['errors'][0]["message"]).to eql "Body has already been taken"
    end

 end
end