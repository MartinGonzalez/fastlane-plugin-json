require "fileutils"

describe "write_json should" do
  FILE_DIR = "#{__dir__}/resources/tmp"

  after :each do
    FileUtils.rm_rf(FILE_DIR) if File.directory?(FILE_DIR)
  end

  it "save a json file containing the hash values in the provided path" do
    hash_value = {
      name: "Martin",
      age: 29,
      languages: [
        "English",
        "Spanish"
      ]
    }

    expect(File.exist?("#{FILE_DIR}/my_json.json"))

    Fastlane::Actions::WriteJsonAction.run({
      file_path: "#{FILE_DIR}/my_json.json",
      hash: hash_value
    })
  end

  it "raise an error if hash: value is nil" do
    expect(Fastlane::UI).to receive(:user_error!)

    Fastlane::Actions::WriteJsonAction.run({
      file_path: "#{FILE_DIR}/my_json.json",
      hash: nil
    })
  end

  it "raise an error if file_path: value is nil" do
    expect(Fastlane::UI).to receive(:user_error!)

    Fastlane::Actions::WriteJsonAction.run({
      file_path: nil,
      hash: {}
    })
  end
end
