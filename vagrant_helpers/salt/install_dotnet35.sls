---
# Salt state to attempt installing .NET version 3.5 (which is not an easy thing to do on modern Windows versions)
#
{#  test whether it is already installed by checking a registry key #}
{% set has_35 = 0 == salt['cmd.retcode']('reg query "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\NET Framework Setup\\NDP\\v3.5" /v install') %}

{%  if has_35 %}

checked_dotnet35:
  test.nop:
    - name: dotnetfx35 is already installed

{%  else %}

  {% if 'erver' in salt['grains.get']('osrelease', '') %}
cannot_install_dotnet35:
{#  suggestion from https://stackoverflow.com/questions/23631675/install-net-3-5-framework-on-windows-server-2012-without-dvd #}
  #reg.present:
  #  - name: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Servicing
  #  - vname: RepairContentServerSource
  #  - vdata: 2
  #  - vtype: DWORD
  test.fail_without_changes:
    - name: Please install .NET FX 3.5 manually using Server Manager and your distribution media. Sorry.
    - order: last

  {% else %}
{#  Windows 10 will complain, ask permission of the user, and download its own version. #}
{#  older windows versions should just install from the supplied file #}
install_dotnet35_0:
  {% set tmpexe = salt['temp.file']('.exe') %}
  file.managed:
    - name: {{ tmpexe }}
    - source: http://shares.digvil.info/dotnetfx35.exe  {# a cached copy of the Microsoft redistributable #}
    - source_hash: d481cda2625d9dd2731a00f482484d86
  cmd.run:
    - name: '{{ tmpexe }} /passive'
install_dotnet35_1:
   file.absent:
      - name: {{ tmpexe }}
  {% endif %}
{% endif %}
...
