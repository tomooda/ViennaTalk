toolbuilder
buildWith: builder
	| windowSpec window |
	windowSpec := self buildWindowWith: builder specs: {
		(0@0 corner: 0.38@0.38)  -> [self buildModuleListWith: builder].
		(0.38@0.0 corner: 0.62@0.38) -> [self buildFieldListWith: builder].
		(0.62@0.0 corner: 1@0.38) -> [self buildValuePaneWith: builder].
		(0.0@0.38 corner: 1@1) -> [self buildCodePaneWith: builder].
	}.
	window := builder build: windowSpec.
	fieldListPane := builder widgetAt: #fieldListPane.
	valuePane := builder widgetAt: #valuePane.
	codePane := builder widgetAt: #codePane.
	^ window