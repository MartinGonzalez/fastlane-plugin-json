describe "read_json should" do
  it "load a hash containing name and age property from json file" do
    json = Fastlane::Actions::ReadJsonAction.run({
      json_path: "#{__dir__}/resources/example.json"
    })

    expect(json).to have_key(:name)
    expect(json).to have_key(:age)
    expect(json[:name]).to eq("Martin")
    expect(json[:age]).to eq(30)
  end

  it "raise an error when json path is not valid" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    Fastlane::Actions::ReadJsonAction.run(
      json_path: "invalid/path"
    )
  end

  it "raise an error when json content is invalid" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    Fastlane::Actions::ReadJsonAction.run(
      json_path: "#{__dir__}/resources/invalid.json"
    )
  end
end
