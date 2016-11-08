class initialization
initialize
	self installEventHandlers.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]