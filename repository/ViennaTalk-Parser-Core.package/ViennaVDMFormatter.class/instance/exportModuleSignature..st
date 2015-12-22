formatting-interfaces
exportModuleSignature: aViennaNode
	| exportSignatures |
	exportSignatures := self formatAll: aViennaNode.
	^ String cr join: exportSignatures