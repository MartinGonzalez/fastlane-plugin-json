require "fileutils"

describe "write_json should" do
  let(:file_dir) { "#{__dir__}/resources/tmp" }

  after :each do
    FileUtils.rm_rf(file_dir) if File.directory?(file_dir)
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

    expect(File.exist?("#{file_dir}/my_json.json"))

    Fastlane::Actions::WriteJsonAction.run({
      file_path: "#{file_dir}/my_json.json",
      hash: hash_value
    })
  end

  it "raise an error if hash: value is nil" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    expect do
      Fastlane::Actions::WriteJsonAction.run({
        file_path: "#{file_dir}/my_json.json",
        hash: nil
      })
    end.to raise_error(StandardError)
  end

  it "raise an error if file_path: value is nil" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    expect do
      Fastlane::Actions::WriteJsonAction.run({
        file_path: nil,
        hash: {}
      })
    end.to raise_error(StandardError)
  end
end
