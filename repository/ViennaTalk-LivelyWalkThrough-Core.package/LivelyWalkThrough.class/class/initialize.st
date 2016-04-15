class initialization
initialize
	super initialize.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]