---
# Salt state for installing Python 2, etc
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

python35_x86:
  pkg.installed:
    - force_x6: True

python35:
  pkg.installed

python36:
  pkg.installed

python36_x86:
  pkg.installed:
    - force_x6: True

python37_x86:
  pkg.installed:
    - force_x6: True

python37:
  chocolatey.installed:
    - name: python
    - install_args:
      - side_by_side
