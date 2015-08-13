script list menu
inspectIt
	self selectedScript
		ifNotNilDo: [:script | script value inspect]