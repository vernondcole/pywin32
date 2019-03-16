---
# Salt state for installing the chocolatey installation tool
#
include:  {# ensure that the definitions are present #}
  - local_windows_repository
  - install_db_providers

python2_x86:
  pkg.installed:
    - force_x6: True

python2:
  chocolatey.installed:
    - name: python2

