value pane
accept: aString var: varName
	| oldValue |
	oldValue := vdmc plainAt: varName ifAbsent: [ ^ false ].
	vdmc plainAt: varName put: aString.
	vdmc
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			vdmc plainAt: varName put: oldValue.
			^ false ].
	vdmc changed: #state.
	^ true