formatting-interfaces
importDefinition: aViennaNode
	| identifier moduleSignature |
	identifier := self format: aViennaNode first.
	moduleSignature := self format: aViennaNode second.
	^ self indentString: 'from ' , identifier insertCrIfNeeded: moduleSignature