require ('spec_helper')

describe "test api" do
  it "responds" do
    get "/api/test"
    expect_json({test: "ok"})
  end
end
