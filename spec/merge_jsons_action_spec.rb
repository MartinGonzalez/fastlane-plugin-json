require "fileutils"

describe "merge_jsons should" do
  let(:file_dir) { "#{__dir__}/resources" }
  let(:file_temp_dir) { "#{__dir__}/resources/tmp" }

  after :each do
    FileUtils.rm_rf(file_temp_dir) if File.directory?(file_temp_dir)
  end

  it "returns a hash containing the values when one path is provided" do
    hash = Fastlane::Actions::MergeJsonsAction.run({
      jsons_paths: [
        "#{file_dir}/example.json"
      ]
    })

    expect(hash).to have_key(:name)
    expect(hash).to have_key(:age)
  end

  it "returns a hash containing values from different jsons" do
    hash = Fastlane::Actions::MergeJsonsAction.run({
      jsons_paths: [
        "#{file_dir}/example.json",
        "#{file_dir}/example2.json"
      ]
    })

    expect(hash).to have_key(:name)
    expect(hash).to have_key(:age)
    expect(hash).to have_key(:isDev)
    expect(hash).to have_key(:lastName)

    expect(hash[:age]).to be(33)
  end

  it "returns a hash containing values from different jsons and save json file at output_path" do
    hash = Fastlane::Actions::MergeJsonsAction.run({
      jsons_paths: [
        "#{file_dir}/example.json",
        "#{file_dir}/example2.json"
      ],
      output_path: "#{file_temp_dir}/tmp.json"
    })

    expect(hash).to have_key(:name)
    expect(hash).to have_key(:age)
    expect(hash).to have_key(:isDev)
    expect(hash).to have_key(:lastName)
    expect(hash[:age]).to be(33)

    expect(File.exist?("#{file_temp_dir}/tmp.json"))
  end

  it "raise an UI error if jsons_paths is empty" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    expect { Fastlane::Actions::MergeJsonsAction.run({ jsons_paths: [] }) }.to raise_error(StandardError)
  end

  it "raise an UI error if a json path is invalid" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    jsons_paths = [
      "#{file_dir}/example.json",
      "#{file_dir}/not-exist.json"
    ]

    expect do
      Fastlane::Actions::MergeJsonsAction.run({ jsons_paths: jsons_paths })
    end.to raise_error(StandardError)
  end

  it "raise an UI error if a json file is invalid" do
    expect(FastlaneCore::UI).to receive(:user_error!)

    jsons_paths = [
      "#{file_dir}/example.json",
      "#{file_dir}/invalid.json"
    ]

    expect { Fastlane::Actions::MergeJsonsAction.run({ jsons_paths: jsons_paths }) }.to raise_error(StandardError)
  end
end
