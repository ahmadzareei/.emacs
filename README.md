

* This is my emacs configuration that I use for my emacs


* Starting

In order to use this configuration, first you need to install cask.

Clone this repository and change the name to .emacs.d

go into .emacs.d and clone cask.

After installing cask, call it by entering the .emacs.d in terminal and running
./.cask/bin/cask

Cask will install all the required packages.


* Editing a little bit

After that, since org package is not updated, I have included in the init file first to change the org library that is being used.
Go to the init.el file and make sure that the address to your org-mode library is correct
  (setq custom-org-path "/home/mathiew/.emacs.d/.cask/24.5/elpa/org-20171225")   

* You are set and good to go. 

