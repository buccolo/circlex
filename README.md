# Circlex

## Installation

Download and compile via mix. (You might need to update your Elixir to 1.4+)

```
mix escript.install github buccolo/circlex
```

## Usage

Make sure you have `~/.mix/escripts` in your $PATH.

### Check

Returns the current status of a project in the given branch.

```
$ circlex check organization/project branch
fixed
```

### Watch

Monitors the build and notifies when the status change.

```
$ circlex watch organization/project branch
Watching organization/project on branch branch
.
.
.
.
.
```
