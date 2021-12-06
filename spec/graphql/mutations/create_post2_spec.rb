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
 context "creates a post"  do
    it "result can not blank" do
        user = create(:user)
        result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
        data = result.dig('data',  'createPost', 'post')
        expect(data['id']).to_not be_nil
    end

    it "result return correct data" do
        user = create(:user)
        result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
        data = result.dig('data',  'createPost', 'post')
        expect(data).to eq({"id"=> data['id'], "title"=> "title", "body"=> "body"})
    end
 end

 context "return correct errors" do 
    it "should raise error when user id is not correct" do
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: 1}).as_json
      data = result.dig('errors')
      expect(data[0]["message"]).to eql "user not found"
    end

    it "should raise error in body uniqueness validation" do
      user = create(:user)
      RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
      data = result.dig('errors')
      expect(data[0]["message"]).to eql "Body has already been taken"
    end

 end
end