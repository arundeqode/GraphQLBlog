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

 let(:user) { create(:user) }

 let(:post) { create(:post, user: user, body: "body") }

 context "when a post is created"  do
    it "is expected to create a post" do
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
      data = result.dig('data',  'createPost', 'post')
      expect(data['id']).to_not be_nil
    end
 end

 context "When user is not present" do 
    it "is expected to raise user not found error" do
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: 1}).as_json
      expect(result['errors'][0]["message"]).to eql "user not found"
    end
 end

 context "When post body is not unique" do 
    before { post }

    it "is expected to raise error of body uniqueness" do
      result = RailsApiGraphqlCrudTutoSchema.execute(mutation, variables: {userId: user.id}).as_json
      expect(result['errors'][0]["message"]).to eql "Body has already been taken"
    end
 end 
end