code pane menu
codePaneMenu: aMenu shifted: aBoolean
	aMenu target: self.
	aMenu
		addList:
			{{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('format (F)' translated).
			#prettyPrint}.
			{('template (T)' translated).
			#template}.
			#-.
			{('do it (d)' translated).
			#codePaneDoIt}.
			{('print it (p)' translated).
			#codePanePrintIt}.
			#-.
			{('accept (s)' translated).
			#accept}.
			{('cancel (l)' translated).
			#cancel}}.
	^ aMenu