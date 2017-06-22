*ViennaTalk-Parser-Code Generators
asViennaTracingString: anObject
	^ ViennaTracingString
		string: self
		sources: (OrderedCollection with: (1 to: self size) -> anObject)