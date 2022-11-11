# Models Bundle

A brick to create multiple models including their properties and all the supporting methods/extensions!

This brick is primarily meant to be used with a config template to generate multiple models using the existing [model brick](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/model)

## Table of Contents

- [How to use](#how-to-use-🚀)
  - [Model from Config](#config)
- [Outputs](#outputs-📦)

## How to use 🚀

### Config

`mason make model -c models_bundle_config.json`

[Example Config](https://github.com/LukeMoody01/mason_bricks/tree/master/bricks/models_bundle/models_config_template.json):

```json
{
  "models": [
    {
      "model_name": "chat",
      "additionals": ["copyWith", "json", "equatable"],
      "style": "json_serializable",
      "relations": [{ "name": "person" }],
      "properties": [
        { "name": "id", "type": "int" },
        { "name": "message", "type": "String" },
        { "name": "sentTime", "type": "DateTime" },
        { "name": "chatImage", "type": "String" },
        { "name": "isForwarded", "type": "bool" },
        { "name": "toUsers", "type": "List<Person>" }
      ]
    },
    {
      "model_name": "person",
      "additionals": ["copyWith", "json", "equatable"],
      "style": "json_serializable",
      "properties": [
        { "name": "id", "type": "int" },
        { "name": "firstName", "type": "String" },
        { "name": "lastName", "type": "String" },
        { "name": "age", "type": "int" },
        { "name": "isHappy", "type": "bool" },
        { "name": "favouriteNumber", "type": "int" },
        { "name": "nicknames", "type": "List<String>" },
        { "name": "countriesVisited", "type": "List<String>" },
        { "name": "organizationId", "type": "String" }
      ]
    },
    {
      "model_name": "organization",
      "additionals": ["copyWith", "json", "equatable"],
      "style": "json_serializable",
      "relations": [{ "name": "person" }],
      "properties": [
        { "name": "id", "type": "int" },
        { "name": "name", "type": "String" },
        { "name": "users", "type": "List<Person>" },
        { "name": "address", "type": "String" }
      ]
    },
...
  ]
}
```

## Variables for a Config ✨

| Variable | Description                           | Type  |
| -------- | ------------------------------------- | ----- |
| `models` | The models you would like to generate | Array |

## Outputs 📦

`mason make model -c models_bundle_config.json`

```
├── models
│   ├── chat.dart
│   ├── chat.g.dart
│   ├── inbox_item.dart
│   ├── inbox_item.g.dart
│   ├── organization.dart
│   ├── organization.g.dart
│   └── organization.freezed.dart
└── ...
```
