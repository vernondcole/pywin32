---
# Salt state for installing Windows SDK version 8.1
#

windows-sdk-8.1:
  chocolatey.installed:
    - name: windows-sdk-8.1
...
