request handling-html
vdmjCopyrightPage
	| page|
	page := String new writeStream.
	page nextPutAll: '<html>'.
	page cr; nextPutAll: '<head>'.
	page cr; nextPutAll: '<title>about VDMJ</title>'.
	page cr; nextPutAll: '</head>'.
	page cr; nextPutAll: '<body>'.
	page cr; nextPutAll: '<div id="all" style="width: 640px">'.
	page cr; nextPutAll: '<div id="main" style="float: right; width: 560px">'.
	page cr; nextPutAll: '<div id="title">'.
	page cr; nextPutAll: '<div style="float: left; font-family: Helvetica, sans-serif; font-size:40px; font-weight: 100">about VDMJ</div> '.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<div id="ide" style="width: 100%; float: right">'.
	page cr; nextPutAll: '<p>VDMPad uses VDMJ as an execution engine.'.
	page cr; nextPutAll: 'Please note that VDMJ is copyrighted and licensed independent of VDMPad.'.
	page cr; nextPutAll: 'Please visit the link below and the copyright notice for details.</p>'.
	page cr; nextPutAll: '<a target="VDMJHome" href="https://sites.google.com/site/nickbattle/home/vdmj"> VDMJ homepage</a><hr>'.
	page cr; nextPutAll: '<pre>/*******************************************************************************
 *
 *	Copyright (C) 2008-2013 Fujitsu Services Ltd.
 *
 *	Author: Nick Battle
 *
 *	VDMJ is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	VDMJ is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with VDMJ.  If not, see <http://www.gnu.org/licenses/>.
 *
 ******************************************************************************/
</pre>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</body>'.
	page cr; nextPutAll: '</html>'.
	^ self responseHtml: page contents