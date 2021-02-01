#!/bin/sh

# With problem matchers in a container, the matcher config MUST be available
# outside the container on the VM so we will just copy it into the workspace.
# See: https://github.com/actions/toolkit/issues/205#issuecomment-557647948
matcher_path=`pwd`/git-grep-problem-matcher.json
cp /git-grep-problem-matcher.json "$matcher_path"

echo "::add-matcher::git-grep-problem-matcher.json"

tag="FIXME"
# See test/should-match for examples of FIXMEs that should match
result=$(git grep --no-color -n -E -e "${tag}\s*(\([^)]+\))?\s*:")

echo "${result}"

if [ -n "${result}" ] && [ "${ENVIRONMENT}" != "test" ]; then
  exit 1
fi
