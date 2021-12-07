require 'rails_helper'

describe ".resolve" do
 let(:query) do
    <<~GQL
        query($id: ID) {
            user(id: $id) {
                id
                name
                email
            }      
          }
    GQL
 end

 let(:user) { create(:user) }

 context "when fetch a user"  do
  it "is expected to return user" do
    result = RailsApiGraphqlCrudTutoSchema.execute(query, variables: {id: user.id}).as_json
    data = result.dig('data',  'user')
    expect(data['id']).to_not be_nil
  end
 end

 context "when user is not present" do 
  it "is expected to raise error user does not exist." do
    result = RailsApiGraphqlCrudTutoSchema.execute(query, variables: {id: nil}).as_json
    data = result.dig('errors')
    expect(data[0]["message"]).to eql "User does not exist."
  end
 end

end