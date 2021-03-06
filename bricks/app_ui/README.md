# App UI

A brick to create your UI package that holds all your app's Colors, Typography, Layout, Theme, and more!

## How to use 🚀

```
mason make app_ui --project_name app
```

## Variables ✨

| Variable       | Description             | Default | Type     |
| -------------- | ----------------------- | ------- | -------- |
| `project_name` | The name of the project | app     | `string` |

## Outputs 📦

```
--project_name app
├── app_ui
│   ├── assets
│   │   └── fonts
│   │   │   └── .ttfs
│   ├── lib
│   │   ├── src
│   │   │   ├── layout
│   │   │   │   ├── breakpoints.dart
│   │   │   │   └── layout.dart
│   │   │   ├── typography
│   │   │   │   ├── font_weights.dart
│   │   │   │   ├── text_styles.dart
│   │   │   │   └── typography.dart
│   │   │   ├── widgets
│   │   │   │   ├── responsive_layout_builder.dart
│   │   │   │   └── widgets.dart
│   │   │   ├── colors.dart
│   │   │   └── theme.dart
│   │   └── app_ui.dart
│   └──
└── ...
```
