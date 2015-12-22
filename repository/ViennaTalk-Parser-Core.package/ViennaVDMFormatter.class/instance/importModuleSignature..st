formatting-interfaces
importModuleSignature: aViennaNode
	| importSignatures |
	importSignatures := self formatAll: aViennaNode.
	^ String cr join: importSignatures