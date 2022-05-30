# Fastlane Json plugin <!-- omit in toc -->

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-json) ![Gem Version](https://badge.fury.io/rb/fastlane-plugin-json.svg) ![](https://ruby-gem-downloads-badge.herokuapp.com/fastlane-plugin-json) [![YourActionName Actions Status](https://github.com/MartinGonzalez/fastlane-plugin-json/workflows/Test-Build-Publish/badge.svg)](https://github.com/MartinGonzalez/fastlane-plugin-json/actions)

- [Getting Started](#getting-started)
- [Actions](#actions)
    - [read_json](#read_json)
    - [download_json](#download_json)
    - [write_json](#write_json)
    - [merge_jsons](#merge_jsons)
- [Example](#example)
- [Run tests for this plugin](#run-tests-for-this-plugin)
- [Issues and Feedback](#issues-and-feedback)
- [Troubleshooting](#troubleshooting)
- [Using _fastlane_ Plugins](#using-fastlane-plugins)
- [About _fastlane_](#about-fastlane)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-json`,
add it to your project by running:

```bash
fastlane add_plugin json
```

## Actions

This plugin provide several actions that will allow you to manipulate and create json files.

### read_json

| Key       | Description       | Env Var | Default |
|-----------|-------------------|---------|---------|
| json_path | Path to json file |         |         |
| verbose   | verbose           |         |  false  |

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

| Key      | Description                     | Env Var | Default |
|----------|---------------------------------|---------|---------|
| json_url | Url to json file                |         |         |
| username | Basic auth username to download |         |         |
| password | Basic auth password to download |         |         |
| verbose  | verbose                         |         |  false  |

Downloads a json file from server and convert it to a hash object.

```ruby
my_json = download_json(
  json_url: "https://gist.githubusercontent.com/MartinGonzalez/77b28af666fc2ee844c96cf6c8c221a2/raw/d23feabf25abe39c9c7243fd23f92efa7f50a3fd/someExample.json",
  username: "admin",
  password: "admin123"
)

puts my_json[:name]
# "Martin Gonzalez"
puts my_json[:gender]
# "male"
puts my_json[:isDev]
# true
```

### write_json

| Key       | Description                               | Env Var | Default |
|-----------|-------------------------------------------|---------|---------|
| hash      | Hash that you want to save as a json file |         |         |
| file_path | Path where you want to save your json     |         |         |
| verbose   | verbose                                   |         |  false  |

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

### merge_jsons

| Key         | Description                               | Env Var | Default |
|-------------|-------------------------------------------|---------|---------|
| jsons_paths | Array of json files paths                 |         |         |
| output_path | Output path where result will be saved    |         |         |
| verbose     | verbose                                   |         |  false  |

Merges several json files into one hash as output. Also you can set the `output_path` to save the merged hash into a
json file.

Having this files:

`example.json`

```json
{
  "name": "Martin",
  "age": 30
}
```

`example2.json`

```json
{
  "lastName": "Gonzalez",
  "age": 40,
  "isDev": true
}
```

```ruby
output_path = "#{__dir__}/tmp/merged.json"

merged_hash = merge_jsons(
  jsons_paths: [
    "path/to/example.json",
    "path/to/example2.json"
  ],
  output_path: output_path
)

# {:name=>"Martin", :age=>40, :lastName=>"Gonzalez", :isDev=>true}
```

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo,
running `fastlane install_plugins` and `bundle exec fastlane all`.

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

If you have trouble using plugins, check out
the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out
the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more,
check out [fastlane.tools](https://fastlane.tools).
