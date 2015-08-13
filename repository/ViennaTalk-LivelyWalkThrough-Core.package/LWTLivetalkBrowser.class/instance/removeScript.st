script list menu
removeScript
	self director
		removeScriptAt: self selectedScriptSelector
		ifAbsent: [].
	self changed: #scriptList.
	self selectScriptNamed: nil