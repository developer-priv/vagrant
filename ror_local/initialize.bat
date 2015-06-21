REM Destroying existing Vagrant machine, if any
vagrant destroy -f

REM Removing vagrant machine directory to start with clean state
rd /s /q .vagrant

REM Starting new machine
vagrant up
