json
widgetsFromJsonObject: anArray
	self removeAllMorphs.
	anArray do: [ :json | (LWTWidget fromJsonObject: json on: self) ifNotNil: [ :widget | self addMorphBack: widget ] ]