Class {
	#name : 'ViennaInlineLet',
	#superclass : 'ViennaInline',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaInlineLet >> check [

	ast ifNil: [ ^ false ].
	ast isViennaLetNode ifFalse: [ ^ false ].
	ast localDefinitionsDo: [ :localValueDefinition |
		localValueDefinition isViennaValueDefinitionNode ifFalse: [
			^ false ].
		localValueDefinition pattern isViennaPatternIdentifierNode ifFalse: [
			^ false ] ].
	^ true
]

{ #category : 'operations' }
ViennaInlineLet >> execute [

	| defs |
	defs := Array streamContents: [ :stream |
		        ast localDefinitionsDo: [ :valueDefinition |
			        stream nextPut:
				        valueDefinition pattern identifier
				        -> valueDefinition expression ] ].
	[ defs notEmpty ] whileTrue: [
		| nextDef |
		nextDef := defs
			           detect: [ :def |
				           defs allSatisfy: [ :assoc |
					           (def value hasFreeIdentifier: assoc key) not ] ]
			           ifNone: [ nil ].
		nextDef ifNil: [ ^ self ].
		defs := defs copyWithout: nextDef.
		ast body freeIdentifiersExcept: Set new do: [ :identifier :node |
			identifier = nextDef key ifTrue: [
				self replaceNode: node with: nextDef value copyFragment ] ].
		defs do: [ :def |
			def value freeIdentifiersExcept: Set new do: [ :identifier :node |
				identifier = nextDef key ifTrue: [
					self replaceNode: node with: nextDef value copyFragment ] ] ] ].
	^ self replaceNode: ast with: ast body
]

{ #category : 'accessing' }
ViennaInlineLet >> sortingOrder [
	^ 2.17
]
