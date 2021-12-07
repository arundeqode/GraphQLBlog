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

 let(:result) do
    user = create(:user)
    result = RailsApiGraphqlCrudTutoSchema.execute(query, variables: {id: user.id}).as_json
 end

 context "when try get user"  do
  it "result can not blank" do
    data = result.dig('data',  'user')
    expect(data).to_not be_nil
  end
 end

 context "when error occurs" do 
  it "it expect to raise error when user is not present" do
    result = RailsApiGraphqlCrudTutoSchema.execute(query, variables: {id: nil}).as_json
    data = result.dig('errors')
    expect(data[0]["message"]).to eql "User does not exist."
  end
 end

end