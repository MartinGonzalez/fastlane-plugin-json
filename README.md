# Fastlane Json plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-json)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-json`, add it to your project by running:

```bash
fastlane add_plugin json
```

## About json

This plugin provide several actions that will allow you to manipulate and create json files.

### read_json

Read a json file at specific path as a hash object.

_Having a json file at `path/to/my.json` with the following content:_

```json
{
    "name": "Martin",
    "age": 30
}
```

```ruby
my_json = read_json(
    json_path: "path/to/my.json"
)

puts my_json[:name]
# "Martin"
puts my_json[:age]
# 30
```

### download_json

Downloads a json file from server and convert it to a hash object.

```ruby
my_json = download_json(
    json_url: "https://gist.githubusercontent.com/MartinGonzalez/77b28af666fc2ee844c96cf6c8c221a2/raw/d23feabf25abe39c9c7243fd23f92efa7f50a3fd/someExample.json"
)

puts my_json[:name]
# "Martin Gonzalez"
puts my_json[:gender]
# "male"
puts my_json[:isDev]
# true
```

### write_json

Creates a json file from a hash.

```ruby
hash_value = {
      name: "Martin",
      age: 30,
      languages: [
        "English",
        "Spanish"
      ]
    }

write_json(
    file_path: "#{__dir__}/my_json.json",
    hash: hash_value
)
```

Will create a my_json.json file with the following content:

```json
{
  "name": "Martin",
  "age": 30,
  "languages": [
    "English",
    "Spanish"
  ]
}
```

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

**Note to author:** Please set up a sample project to make it easy for users to explore what your plugin does. Provide everything that is necessary to try out the plugin in this project (including a sample Xcode/Android project if necessary)

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
