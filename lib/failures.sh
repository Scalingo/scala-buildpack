#!/usr/bin/env bash

set -euo pipefail

handle_sbt_errors() {
	local log_file="${1}"

	if grep -qi 'Not a valid key: stage' "${log_file}"; then
		output::error <<-EOF
			Fail to run sbt!
			It looks like your build.sbt does not have a valid 'stage' task.
			Please read our documentation for information on how to create one:
			https://doc.scalingo.com/languages/scala/start#not-a-valid-command-stage

			Thanks,
			Scalingo
		EOF
	elif grep -qi 'is already defined as object' "${log_file}"; then
		output::error <<-EOF
			Fail to run sbt!
			We're sorry this build is failing. It looks like you may need to run a
			clean build to remove any stale SBT caches. You can do this by setting
			a configuration variable like this:

				$ scalingo env-set SBT_CLEAN=true

			Then deploy you application with 'git push' again. If the build succeeds
			you can remove the variable by running this command

				$ scalingo env-unset SBT_CLEAN

			If this does not resolve the problem, please get in touch with our
			support team.

			Thanks,
			Scalingo
		EOF
	else
		output::error <<-EOF
			Fail to run sbt!
			We're sorry this build is failing. If you can't find the issue in
			application code, please get in touch with our support team.
	
			You can also try reverting to the previous version of the buildpack
			by running:

				$ scalingo --app my-app env-set BUILDPACK_URL=https://github.com/Scalingo/scala-buildpack#previous-version"

			Thanks,
			Scalingo
		EOF
	fi
}
