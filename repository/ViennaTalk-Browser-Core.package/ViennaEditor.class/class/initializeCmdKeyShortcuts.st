keyboard shortcut tables
initializeCmdKeyShortcuts
	"Initialize the (unshifted) command-key (or alt-key) shortcut table."



	"
	ViennaEditor initialize
	"

	| cmds |
	self initializeBasicCmdKeyShortcuts.
			
	'0123456789-=' 
		do: [:char | cmdActions at: char asciiValue + 1 put: #changeEmphasis:].
	
	cmds := #(
		$d #doIt: 
		$z #undo: 
		$j #redo: 
		$l #cancel: 
		$p #printIt: 
		$s #save: ).
	1 to: cmds size
		by: 2
		do: [:i | self cmdActions at: (cmds at: i) asciiValue + 1 put: (cmds at: i + 1)]