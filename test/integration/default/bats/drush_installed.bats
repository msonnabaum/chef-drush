#!/usr/bin/env bats

@test "drush binary is found in PATH" {
  run which drush
  [ "$status" -eq 0 ]
}
