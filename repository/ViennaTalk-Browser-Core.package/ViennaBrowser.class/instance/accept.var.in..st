value pane
accept: aString var: varName in: moduleName
	| key oldValue |
	key := moduleName , '`' , varName.
	oldValue := vdmc plainAt: key ifAbsent: [ ^ false ].
	vdmc plainAt: key put: aString.
	vdmc
		plainEvaluate: 'nil'
		ifError: [ :msg | 
			valuePane
				handleEdit: [ 
					valuePane textMorph editor
						selectFrom: aString size to: aString size - 1;
						afterSelectionInsertAndSelect: msg ].
			vdmc plainAt: key put: oldValue.
			^ false ].
	vdmc changed: #state.
	^ true