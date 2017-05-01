# == Class: vpackages
#
# This is the main class for VPackages that generates all of the virtual
# package resources based on an input hiera hash for other modules to realize
# to minimize package conflicts between modules that require the same packages.
#
# === Parameters
#
# [*packages*]
#   REQUIRED: A hash of all the packages and desired options for the package.
#
# [*purge_yumrepos*]
#   Whether to purge unmanaged yumrepos from the system, default: false
#
# [*realize_packages*]
#  OPTIONAL: An array of the virtual packages that should be realized with their
#  configured state from the packages hash.
#
# [*realize_yumrepos*]
#  OPTIONAL: An array of the virtual yumrepos that should be realized with their
#  configured state from the yumrepos hash.
#
# [*yumrepos*]
#  OPTIONAL: A hash of all the yumrepos and desired options for the repo.
#
class vpackages (
  $packages         = {},
  $purge_yumrepos   = false,
  $realize_packages = [],
  $realize_yumrepos = [],
  $yumrepos         = {},
) {
  validate_hash($packages)
  validate_array($realize_packages)
  validate_array($realize_yumrepos)
  validate_hash($yumrepos)

  if $packages == undef {
    fail("You must put a hash in hiera for ${name}::packages")
  }

  create_resources('@package', $packages)

  if $yumrepos {
    create_resources('@yumrepo', $yumrepos)
  }

  if $purge_yumrepos {
    resources { 'yumrepo':
      purge => true,
    }
  }

  if $realize_packages {
    realize Package[$realize_packages]
  }

  if $realize_yumrepos {
    realize Yumrepo[$realize_yumrepos]
  }
}
