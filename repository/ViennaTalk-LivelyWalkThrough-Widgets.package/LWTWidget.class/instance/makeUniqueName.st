private
makeUniqueName
	| prefix random uniqueName |
	prefix := self basename.
	random := Random new.
	[ 
	uniqueName := prefix , (random nextInt: 999999) printString.
	(self director ifNil: [ World ])
		findDeepSubmorphThat: [ :m | m ~~ self and: [ (m isKindOf: LWTWidget) and: [ m name = uniqueName ] ] ]
		ifAbsent: [ ^ uniqueName ] ] repeat