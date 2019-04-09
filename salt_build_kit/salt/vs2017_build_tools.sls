---
# Salt state for installing Visual Studio C++ non-GUI compiler
#
include:
  - .install_chocolatey

visualstudio2017buildtools:
  chocolatey.upgraded:
    - require:
      - install_chocolatey

visualstudio2017-workload-vctools_bt:
  chocolatey.upgraded:
    - name: visualstudio2017-workload-vctools
    - require:
      - visualstudio2017buildtools
...
