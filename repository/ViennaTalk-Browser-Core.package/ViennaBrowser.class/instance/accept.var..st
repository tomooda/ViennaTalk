value pane
accept: aString var: varName
	| oldValue |
	oldValue := animation plainAt: varName ifAbsent: [ ^ false ].
	animation plainAt: varName put: aString.
	animation
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			animation plainAt: varName put: oldValue.
			^ false ].
	animation changed: #state.
	^ true