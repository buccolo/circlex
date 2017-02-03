# Circlex

## Installation

Download and compile via mix. (You might need to update your Elixir to 1.4+)

```
mix escript.install github buccolo/circlex
```

## Usage

Make sure you have `~/.mix/escripts` in your $PATH.

Create your API token on https://circleci.com/account/api.

You will need to expose it on the `CIRCLECI_TOKEN` environment variable.


### Check

Returns the current status of a project in the given branch.

```
$ circlex check organization/project branch
fixed
```

### Watch

Monitors the build and notifies when the status change. Currently, it displays notifications through AppleScript only.

```
$ circlex watch organization/project branch
Watching organization/project on branch branch
.
.
.
.
.
```

![](http://i.imgur.com/dA7R7oJ.png)
