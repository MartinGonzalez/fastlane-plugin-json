describe "download_json should" do
  it "download and parse json from json url" do
    json = Fastlane::Actions::DownloadJsonAction.run(
      json_url: "https://gist.githubusercontent.com/MartinGonzalez/77b28af666fc2ee844c96cf6c8c221a2/raw/d23feabf25abe39c9c7243fd23f92efa7f50a3fd/someExample.json"
    )

    expect(json).to have_key(:name)
    expect(json).to have_key(:gender)
    expect(json).to have_key(:isDev)
  end

  it "raise an error with a messsage if download fails" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    expect do
      Fastlane::Actions::DownloadJsonAction.run(
        json_url: "https://gist.someunixistingplace.com/dsdssd/dssds/raw/sddssd/someExample.json"
      )
    end.to raise_error(StandardError)
  end

  it "raise an error with a messsage if download succeed but json content is invalid" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    expect do
      Fastlane::Actions::DownloadJsonAction.run(
        json_url: "https://gist.githubusercontent.com/MartinGonzalez/c14ee66436eb9f9c77004f43b4e47ed8/raw/d77fd0648258cf15a6fa30da1b3a887a8332b24a/invalid.json"
      )
    end.to raise_error(StandardError)
  end
end
