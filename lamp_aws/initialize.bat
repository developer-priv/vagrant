REM Destroying existing Vagrant machine, if any
vagrant destroy -f

REM Removing vagrant machine directory to start with clean state
rd /s /q .vagrant

REM In order to use rsync the PATH needs to be set to rsync binaries
REM Because we need to run rsync's version of ssh
REM Otherwise rsync will run Git's version of ssh and throw errors
SET CWRSYNCHOME=C:\Program Files (x86)\cwRsync
REM SET HOME=c:\Users\sabina\ This is probably not necessary
SET PATH=C:\Program Files (x86)\cwRsync\bin;%PATH%

REM Starting new machine
vagrant up --provider=aws
