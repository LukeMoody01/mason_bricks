# 0.5.1

- fix: Update basic_to_json to use current instance instead of passing one through

# 0.5.0

- feat: Allow for seeding/configs for a whole model including the properties

- feat: Relate models to generate their imports (Currently config only)

- chore: Update documentation with information about configs and how it differs from regular command line generation

# 0.4.1

- fix: Update brick.yaml with `defaults` instead of `default`

- chore: Small documentation changes

# 0.4.0

- feat: Allow models to have different styles (basic, json_serializable, freezed)

- feat: Improve API for selecting additional methods/extensions

- cleanup: Make use of partials for better maintainability

- Thanks to @LosDanieloss for his PR addressing freezed support and laying out the initial work for it!

# 0.3.7

- feat: Change model format to split on ' ' instead of '/' making it easier for developers to type properties

# 0.3.6

- chore: Add documentation to reflect new model generation

# 0.3.5

- feat: Add documentation for generated model

# 0.3.4

- fix: Allow no properties to be added without errors

# 0.3.3

- chore: Small documentation changes

# 0.3.2

- chore: Update alert message to reflect new type/name changes (Last version did not update)

# 0.3.1

- chore: Update alert message to reflect new type/name changes
- chore: Small updates to property checking

# 0.3.0

- feat: Support Custom List Types for to/fromJson

# 0.2.1

- fix: Remove extra .dart suffix on generated file

# 0.2.0

- fix: toJson typo fixed
- feat: Support custom types in to/from Json
- feat: Update all properties to be required names parameters as standard

# 0.1.2

- feat: Support types with some type parameters when creating a model
- chore: update pre_gen.dart for readability

# 0.1.1

- fix: Remove extra .dart suffix on generated file

# 0.1.0

- feat: Support List types when creating a model
- feat: Allow unlimited properties to be added
- feat: Add simple format checking
- cleanup: Major cleanup on brick

# 0.0.3

- Update property limit to 15
- Update roadmap documentation

# 0.0.2

- Update documentation

# 0.0.1

- Create initial Model Brick
