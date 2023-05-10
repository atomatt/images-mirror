#!/usr/bin/env bash 

set -eu

image="${1}"

name=$(echo "${image}" | cut -d ":" -f 1)
label=$(echo "${image}" | cut -d ":" -f 2 -s)

ignores=""
if [ ! -z "${label}" ]; then
    if [ -z $(echo "${label}" | cut -d '.' -f 2- -s) ]; then ignores="version-update:semver-major"; fi
    if [ ! -z $(echo "${label}" | cut -d '.' -f 2- -s) ]; then ignores="version-update:semver-major, version-update:semver-minor"; fi
fi

mkdir -p "${image}"

cat > "${image}/Dockerfile" <<EOF
FROM ${image}
EOF

cat >> .github/dependabot.yml <<EOF

  - package-ecosystem: docker
    directory: /${image}
    schedule:
      interval: daily
EOF

if [ ! -z "${ignores}" ]; then
    cat >> .github/dependabot.yml <<EOF
    ignore:
      - dependency-name: ${name}
        update-types: [${ignores}]
EOF
fi
