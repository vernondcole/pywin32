---
# salt state file for all systems
# this is an example of things you may always want installed. #}

{% if grains['os_family'] == 'Windows' %}
include:
  - install_chocolatey

windows_py3:
  chocolatey.installed:
    - names:
      - python3
      - notepadplusplus
      - git
    - require:
      - cmd: install_chocolatey

windows_pygit2_failure_workaround:
   cmd.run:  # install in Salt's copy of Python
     - name: {{ salt['environ.get']('PYTHON') }} -m pip install pygit2

{# Note: .sls files are interpreted on the Minion, so the environment variables are local to it #}
{{ salt['environ.get']('SystemRoot') }}/edit.bat:  {# very dirty way to create an "edit" command for all users #}
  file.managed:
    - contents:
      - '"{{ salt['environ.get']('ProgramFiles') }}\Notepad++\Notepad++.exe" %*'
    - unless:  {# do not install this if there is an existing "edit" command #}
      - where edit
      - require:
        - windows_packages

{{ salt['environ.get']('SystemRoot') }}/tail.bat:  {# very dirty way to create a "tail -f" command for all users #}
  file.managed:
    - contents: |
        @ECHO OFF
        IF "%1"=="-f" (
        powershell get-content "%2" -tail 20 -wait
        ) ELSE (
        start /b powershell get-content "%1" -tail 20
        )
    - unless:  {# do not install this if there is an existing "tail" command #}
      - where tail

{% endif %}  {# Windows #}

{% if grains['os_family'] == 'Debian' %}
debian_packages:
  pkg.installed:
    - pkgs:
      - git
      - nano
      - python-pip
      - python3
      - python3-pip
      - tree
{% endif %}

{% if salt['grains.get']('os') == 'Ubuntu' %}
ubuntu_packages:
  pkg.installed:
    - pkgs:
      {% if grains['osrelease'] < '18.04' %}
      - python-software-properties
      {% endif %}
      - vim-tiny
      - virt-what
      {% if grains['osrelease'] < '16.04' %}
      - python-git  # fallback package if pygit2 is not found.
      {% else %}
      - python-pygit2
      {% endif %}
      {% if grains['locale_info']['defaultlanguage'] != 'en_US' %}
      - 'language-pack-en'
      {% endif %}
{% endif %}
...
