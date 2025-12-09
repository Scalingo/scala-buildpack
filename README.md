# Buildpack: Scala

This is a [Buildpack](http://doc.scalingo.com/buildpacks) for Scala apps.
It uses [sbt](https://github.com/sbt/sbt) 0.11.0+.

## How it works

## Table of Contents

- [Supported sbt Versions](#supported-sbt-versions)
- [Getting Started](#getting-started)
- [Application Requirements](#application-requirements)
- [Configuration](#configuration)
  - [OpenJDK Version](#openjdk-version)
  - [sbt Version](#sbt-version)
  - [Buildpack Configuration](#buildpack-configuration)
- [Documentation](#documentation)


## Supported sbt Versions

This buildpack officially supports sbt `1.x`. Best-effort support is available for apps using sbt `0.13.18`. sbt `2.x` support will be added after its release.

## Getting Started

See the [Getting Started on Scalingo with Scala](https://doc.scalingo.com/languages/scala/scalatra/start) tutorial.

## Application Requirements

Your app requires at least one `.sbt` file and a `project/build.properties` file in the root directory. The `project/build.properties` file must define the `sbt.version` property.

The buildpack uses the `stage` sbt task to build your application. The easiest way to provide this task is with [`sbt-native-packager`](https://github.com/sbt/sbt-native-packager), which includes it by default.

## Configuration

### OpenJDK Version

Specify an OpenJDK version by creating a `system.properties` file in the root of your project directory and setting the `java.runtime.version` property.

### sbt Version

The buildpack uses the `sbt.version` property in your `project/build.properties` file to determine which sbt version to use. Update this property to change the sbt version.

### Buildpack Configuration

Configure the buildpack by setting environment variables:

| Environment Variable | Description | Default |
|---------------------|-------------|---------|
| `SBT_TASKS` | sbt tasks to execute | `compile stage` |
| `SBT_OPTS` | JVM options for sbt execution | (none) |
| `SBT_CLEAN` | Run `clean` task before build | `false` |
| `SBT_PROJECT` | For multi-project builds, specifies which project to build | (none) |
| `SBT_AT_RUNTIME` | Make sbt available at runtime | `true` |
| `KEEP_SBT_CACHE` | Prevent removal of compilation artifacts from slug | `false` |

## Documentation

For more information about using Scala on Scalingo, see the [Scala](https://doc.scalingo.com/langagues/scala) documentation.
