formatting-interfaces
interface: aViennaNode
	| importDefinitionList exportDefinition |
	importDefinitionList := aViennaNode first ifNil: [ '' ] ifNotNil: [ (self format: aViennaNode first) , String cr ].
	exportDefinition := self format: aViennaNode second.
	^ importDefinitionList , exportDefinition