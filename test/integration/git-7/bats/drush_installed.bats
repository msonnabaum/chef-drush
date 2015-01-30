#!/usr/bin/env bats

@test "drush binary is found in PATH" {
  run which drush
  [ "$status" -eq 0 ]
}

@test "drush status runs" {
  run drush status
  [ "$status" -eq 0 ]
}
