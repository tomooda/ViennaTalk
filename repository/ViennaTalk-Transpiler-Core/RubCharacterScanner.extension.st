Extension { #name : 'RubCharacterScanner' }

{ #category : '*ViennaTalk-Transpiler-Core' }
RubCharacterScanner >> scanCharactersFrom: startIndex to: stopIndex in: sourceString rightX: rightX stopConditions: stops kern: kernDelta [

	| string |
	string := sourceString asString.
	string isByteString ifTrue: [
		^ self
			  basicScanCharactersFrom: startIndex
			  to: stopIndex
			  in: string
			  rightX: rightX
			  stopConditions: stops
			  kern: kernDelta ].

	string isWideString ifFalse: [ ^ stops endOfRun ].

	startIndex > stopIndex ifTrue: [
		lastIndex := stopIndex.
		^ stops endOfRun ].

	^ self
		  scanMultiCharactersFrom: startIndex
		  to: stopIndex
		  in: string
		  rightX: rightX
		  stopConditions: stops
		  kern: kernDelta
]
