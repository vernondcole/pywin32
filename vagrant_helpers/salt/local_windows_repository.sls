---
# Salt state for using a local source for Windows software definitions
# - - - this state is to run on the Salt Master
#
{% if grains['os'] == 'Windows' %}
c:/srv/salt/win/repo-ng:
{%  else %}
/srv/salt/win/repo-ng:
{% endif %}
  file.directory:
    - makedirs: true

{# -- NOTE -- no jinja is used in loading the managed files.
  The (.source) jinja template is expanded on the minion only. #}
/srv/salt/win/repo-ng/VCforPython27.sls:
  file.managed:
    - source: salt://{{ slspath }}/files/VCforPython27.sls.source

/srv/salt/win/repo-ng/python2_x86.sls:
  file.managed:
    - source: salt://{{ slspath }}/files/python2_x86.sls.source

# these versions of AceRedist have been altered to load correctly on a machine which
# has had a click-to-buy copy of Microsoft Office installed.
/srv/salt/win/repo-ng/AceRedist_32.sls:
  file.managed:
    - source: salt://{{ slspath }}/files/AceRedist_32.sls.source
/srv/salt/win/repo-ng/AceRedist_64.sls:
  file.managed:
    - source: salt://{{ slspath }}/files/AceRedist_64.sls.source
...
