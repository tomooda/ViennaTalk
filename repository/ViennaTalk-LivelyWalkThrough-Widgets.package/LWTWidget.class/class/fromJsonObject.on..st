json
fromJsonObject: aDictionary on: aLWTDirector
	| widget |
	widget := (Smalltalk at: (aDictionary at: '_class') asSymbol) new.
	aDictionary
		keysAndValuesDo: [ :key :value | 
			key first ~= $_
				ifTrue: [ 
					| selector |
					selector := (key , ':') asSymbol.
					(widget respondsTo: selector)
						ifTrue: [ widget perform: selector with: (self attributeFromJsonObject: value) ] ] ].
	aLWTDirector addMorphBack: widget.
	widget position: (self attributeFromJsonObject: (aDictionary at: '_relativePosition')) + aLWTDirector position.
	^ widget