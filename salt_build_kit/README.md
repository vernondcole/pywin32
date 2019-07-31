# Using Vagrant VMs to Build and Test PyWin32

This sub-directory provides for semi-automatically configuring machines 
capable of building a PyWin32 distribution. 
This can be done using any modern operating system. 
(This subsystem was developed using macOS Mojave.)

### How to run Vagrant Virtual Machines on your workstation.

- open a `cmd` command shell as an Administrator

- using that shell, execute the following script to install [chocolatey](https://chocolatey.org/).

`@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"`
 
- exit from that command shell, and open a new Administrator command shell. (This one will recognize the `choco` command.) 

- Install [git](https://git-scm.com/downloads) on your workstation. 

`git --version || choco install git`

- Install [Vagrant](vagrantup.com) on your workstation. 

`vagrant --version || choco install vagrant`

- Install [VirtualBox](https://www.virtualbox.org) on your workstation. 

`vboxmanage --version || choco install virtualbox`

- Install [Python3](https://python.org) and pywin32.

```
py -3 --version || choco install python3
py -3 -m pip install pywin32 pyyaml ifaddr passlib
```

- exit from the Administrator shell


- If you have not done so already, clone [this repository](https://github.com/mhammond/pywin32) onto your workstation.

`git clone https://github.com/mhammond/pywin32.git`

- clone the [salt-bevy](https://github.com/salt-bevy/salt-bevy)
repo beside this (pywin32) repo. That location contains your Vagrant setup
and is expected by some shell commands.

`git clone https://github.com/salt-bevy/salt-bevy.git`

- Switch your current working directory to the pywin32 working set.

`cd pywin32`

- Run and control virtual machines as needed.

`vgr help`

`vgr up win10`

`vgr status`

`vagrant destroy win10`


##### About the supplied virtual machines.

Four different virtual machines are defined in the supplied Vagrantfile.

Each creates a virtual display on your workstation's graphic screen.
The default username is "vagrant" with a password of "vagrant".

Each image has a Microsoft ® "Evaluation Windows License" valid for a limited time.
Your workstation will operate as a NAT router, giving the VMs access to the Internet.
Each will also have a fixed address on a virtual 172.17.2.0/24 network with
your workstation found at IP `172.17.2.1`.

There will also be a bridged network adapter which will supply an IP address
on your host network, as if the VM were plugged in alongside your workstation.

Your source code (the pywin32 repository working set) will appear as the 
`C:\vagrant` folder on each VM. This is a virtual directory (not a copy) so any edits
made on your workstation (as with an IDE) instantly appear on the VM, and vice versa.

- `test1` an empty Windows 10 machine (with no [salt](https://www.saltstack.com/) code) 
suitable for testing installation of a newly packaged distribution.
This is the default machine, which you will get if you type `vagrant up`
without specifying a machine name. 
IP `172.17.2.201`

- 'win10' a `Windows ® 10` machine which will bootstrap a
masterless [salt](https://www.saltstack.com/) minion,
which will, in turn, install `Visual Studio ® 2017 build tools`
and other software needed to build PyWin32. 
IP `172.17.2.10`

- 'win16' a `Windows Server ® 2016` machine with a salt bootstrap.
IP `172.17.2.16`

- 'win19' a `Windows Server ® 2019` machine with a salt bootstrap.
IP `172.17.2.19`

Control the machines by sending `cmd` commands to them using WinRM. 
(Note that vagrant will convert normal slash `/` charactors into backslash `\ ` in file paths.)
For example:

`vagrant winrm win10 -c "dir c:/vagrant"`

`vagrant winrm test1 -c /vagrant/salt_build_kit/install_python3.bat`

`vagrant winrm test1 -c /vagrant/salt_build_kit/bootstrap_salt.bat`

Send [salt module](https://docs.saltstack.com/en/latest/ref/modules/all/index.html) commands
by using `salt-call`, for example:

- `vagrant winrm win16 "/salt/salt-call state.highstate"`

- `vagrant winrm win16 "/salt/salt-call state.apply pywin_build_machine"`

