value pane
accept: aString var: varName in: moduleName
	| key oldValue |
	key := moduleName , '`' , varName.
	oldValue := animation plainAt: key ifAbsent: [ ^ false ].
	animation plainAt: key put: aString.
	animation
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			animation plainAt: key put: oldValue.
			^ false ].
	animation changed: #state.
	^ true