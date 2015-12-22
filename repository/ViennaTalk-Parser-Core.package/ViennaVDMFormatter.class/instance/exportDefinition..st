formatting-interfaces
exportDefinition: aViennaNode
	| exportSig |
	exportSig := self format: aViennaNode first.
	^ self indentString: 'exports' insertCrIfNeeded: exportSig