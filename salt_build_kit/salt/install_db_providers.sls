---
# Salt state for installing Windows database providers and/or drivers
#
include:  {# ensure that the definitions are present #}
  - local_windows_repository

AceRedist_32:
  pkg.installed

AceRedist_64:
  pkg.installed:  {# do not install if 64 bit WORD is present #}
    - unless: 'reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Common\FilesPaths'
  reg.absent:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Common\FilesPaths
...
