script list
selectedScript
	^ self director
		scriptAt: self selectedScriptSelector
		ifAbsent: []