require 'rails_helper'

describe ".resolve" do
 let(:query) do
    <<~GQL
        query {
            posts {
                id
                title
                body
            }      
          }
    GQL
 end

 let(:result) do
    user = create(:user)
    post = create(:post, user: user)
    post1 = create(:post, body: "body1", user: user)
    result = RailsApiGraphqlCrudTutoSchema.execute(query).as_json
 end

 context "when get all post"  do
  it "is expect to return 2 records" do
    data = result.dig('data',  'posts')
    expect(data.count).to eql 2
  end
 end

end