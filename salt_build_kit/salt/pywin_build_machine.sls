---
# Salt state for provisioning a Windows (or Linux) server to build PyWin32
#

{% if grains['os'] != 'Windows' %}
  {# set up an Ubuntu build machine #}
mono_install:
  pkgrepo.managed:
    - name: "deb https://download.mono-project.com/repo/ubuntu stable-{{ grains['oscodename'] }} main"
    - keyserver: hkp://keyserver.ubuntu.com:80
    - keyid: 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  pkg.installed:
    - names:
      - mono-complete

{% else %} {# Windows #}

{% set vs_version = '2017' %}
include:
  - .install_dotnet35
  - .local_windows_repository
  - .install_python_versions
  - .install_win81_sdk
  - .vc4python
  - .vs{{ vs_version }}_build_tools

{% endif %} {# Windows #}
...
