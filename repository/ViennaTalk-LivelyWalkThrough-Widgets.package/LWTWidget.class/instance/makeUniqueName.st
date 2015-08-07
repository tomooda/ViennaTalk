private
makeUniqueName
	| basename random uniqueName |
	basename := self class name asString.
	random := Random new.
	[ 
	uniqueName := basename , (random nextInt: 999999) printString.
	(self director ifNil: [ World ])
		findDeepSubmorphThat: [ :m | m ~~ self and: [ m name = uniqueName ] ]
		ifAbsent: [ ^ uniqueName ] ] repeat