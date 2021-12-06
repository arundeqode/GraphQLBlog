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

 context "get all post"  do
  it "result can not blank" do
      user = create(:user)
      post = create(:post, user: user)
      result = RailsApiGraphqlCrudTutoSchema.execute(query).as_json
      data = result.dig('data',  'posts')
      expect(data).to_not be_nil
  end

  it "should return atleast one record" do
      user = create(:user)
      post = create(:post, user: user)
      result = RailsApiGraphqlCrudTutoSchema.execute(query).as_json
      data = result.dig('data',  'posts')
      expect(data.count).to eql 1
  end

  it "should return all posts" do 
    user = create(:user)
    post = create(:post, user: user)
    result = RailsApiGraphqlCrudTutoSchema.execute(query).as_json
    data = result.dig('data',  'posts')
    expect(data).to eq([{"id"=> post.id.to_s, "title"=> post.title, "body"=> post.body }])
  end
 end

end