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
	oldBindings := animation state copy.
	prefix := moduleName , '`'.
	newBindings do: [ :assoc | animation plainAt: prefix , assoc key put: assoc value ].
	animation
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			oldBindings keysAndValuesDo: [ :key :value | animation plainAt: key put: value ].
			^ false ].
	animation changed: #state.
	^ true