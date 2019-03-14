---
# Salt state for installing the chocolatey installation tool
#

pkg.refresh_db_pr:
{# Assumes that you ran salt_master.local_windows_repository on the Master #}
  module.run:
    - name: pkg.refresh_db
    - require_in:
      - pkg: AceRedist_32
      - pkg: AceRedist_64

AceRedist_32:
  pkg.installed

AceRedist_64:
  pkg.installed:  {# do not install if 64 bit WORD is present #}
    - unless: 'reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Common\FilesPaths'
  reg.absent:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Common\FilesPaths
...
