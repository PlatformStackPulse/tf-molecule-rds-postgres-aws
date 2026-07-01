# Unit Tests for tf-molecule-rds-postgres-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:      terraform test -test-directory=tests/unit
# Run verbose:   terraform test -test-directory=tests/unit -verbose
# Run specific:  terraform test -test-directory=tests/unit -run "creates_when_enabled"
#
# Assertions target plan-KNOWN values only (tf-label id strings, resource
# counts, input pass-throughs). Computed attributes such as arn/id/endpoint
# are unknown under a mock provider, so they are only checked for the
# disabled (null) case.

mock_provider "aws" {}

variables {
  # tf-label context
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module-required input
  subnet_ids = ["subnet-aaaa1111", "subnet-bbbb2222"]
}

# ---------------------------------------------------------------------------
# Test: module provisions the RDS stack when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  # The DB subnet group name is derived from the tf-label id "eg-test-thing"
  # and is known at plan time.
  assert {
    condition     = output.db_subnet_group_name == "eg-test-thing"
    error_message = "db_subnet_group_name should equal the tf-label id 'eg-test-thing'."
  }

  # The parameter group name is likewise a tf-label-derived, plan-known value.
  assert {
    condition     = output.parameter_group_name == "eg-test-thing"
    error_message = "parameter_group_name should equal the tf-label id 'eg-test-thing'."
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.arn == null
    error_message = "arn must be null when the module is disabled."
  }

  assert {
    condition     = output.id == null
    error_message = "id must be null when the module is disabled."
  }
}
