value pane
acceptBindings: aString in: moduleName
	| newBindings oldBindings prefix |
	newBindings := self
		parseBindings: aString
		ifError: [ :pos :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: pos to: pos - 1;
						afterSelectionInsertAndSelect: msg ].
			^ false ].
	oldBindings := vdmc state copy.
	prefix := moduleName , '`'.
	newBindings do: [ :assoc | vdmc plainAt: prefix , assoc key put: assoc value ].
	vdmc
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			oldBindings keysAndValuesDo: [ :key :value | vdmc plainAt: key put: value ].
			^ false ].
	self changed: #value.
	^ true