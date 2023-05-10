# images-mirror

Simple experiment to stick something in between applications and images
published by third parties to at least give a chance to review what changed
upstream. All automated as much as possibe and sensible.

Goals:

* Collate a catalog of trusted upstream images
* Notify when upstream images change and update catalog
* Allow applications to track images at appropriate semver range
* Easy to maintain

The idea is these images pin (sort of) to the latest image in the $version's
semver range, applications can use $org/golang:$version to track a floating but
trusted image, dependabot PRs help keep the images fresh.

For example:

* golang starts at golang:1.0.0 and floats in the golang:x range
* golang:1 starts at golang:1.0.0 and floats in the golang:1.x range
* golang:1.2 starts at golang:1.2.0 and floats in the golang:1.2.x range
* golang:1.2.3 starts at golang:1.2.3 and floats in the golang:1.2.3 range

Notes:

* There's nothing "pinned" in the hash sense, although image layers would not
  change after the initial build and push to the $org/golang repo.
* You don't really know what the first build pushes
* You could periodically rebuild and push all images but then things are
  changing without you knowing.
* Applications still need to periodically rebuild and retest.
* Someone needs to review dependabot PRs or nothing ever changes.

TODO:

* Simple script to bootstrap an image at a specific semver range.
* Check these would actually be useful from an application's PoV
* Add hashes so images are really pinned and maybe even change if upstream does
  something weird.
