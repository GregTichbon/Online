<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Ajax &mdash; CKEditor Sample</title>
	<meta content="text/html; charset=utf-8" http-equiv="content-type" />
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
	//<![CDATA[

var editor;

function createEditor()
{
	if ( editor )
		return;

	var html = document.getElementById( 'editorcontents' ).innerHTML;

	// Create a new editor inside the <div id="editor">, setting its value to html
	var config = {};
	editor = CKEDITOR.appendTo( 'editor', config, html );
}

function removeEditor()
{
	if ( !editor )
		return;

	// Retrieve the editor contents. In an Ajax application, this data would be
	// sent to the server or used in any other way.
	document.getElementById( 'editorcontents' ).innerHTML = editor.getData();
	document.getElementById( 'contents' ).style.display = '';

	// Destroy the editor.
	editor.destroy();
	editor = null;
}

	//]]>
	</script>
</head>
<body>
	<h1 class="samples">
		CKEditor Sample &mdash; Create and Destroy Editor Instances for Ajax Applications
	</h1>
	<div class="description">
	<p>
		This sample shows how to create and destroy CKEditor instances on the fly. After the removal of CKEditor the content created inside the editing
		area will be displayed in a <code>&lt;div&gt;</code> element.
	</p>
	<p>
		For details of how to create this setup check the source code of this sample page
		for JavaScript code responsible for the creation and destruction of a CKEditor instance.
	</p>
	</div>

	<!-- This <div> holds alert messages to be display in the sample page. -->
	<div id="alerts">
		<noscript>
			<p>
				<strong>CKEditor requires JavaScript to run</strong>. In a browser with no JavaScript
				support, like yours, you should still see the contents (HTML data) and you should
				be able to edit it normally, without a rich editor interface.
			</p>
		</noscript>
	</div>
	<p>Click the buttons to create and remove a CKEditor instance.</p>
	<p>
		<input onclick="createEditor();" type="button" value="Create Editor" />
		<input onclick="removeEditor();" type="button" value="Remove Editor" />
	</p>
	<!-- This div will hold the editor. -->
	<div id="editor">
	</div>
	<div id="contents" style="display: none">
		<p>
			Edited Contents:</p>
		<!-- This div will be used to display the editor contents. -->
		<div id="editorcontents">
		</div>
	</div>
	<div id="footer">
		<hr />
		<p>
			CKEditor - The text editor for the Internet - <a class="samples" href="http://ckeditor.com/">http://ckeditor.com</a>
		</p>
		<p id="copy">
			Copyright &copy; 2003-2011, <a class="samples" href="http://cksource.com/">CKSource</a> - Frederico
			Knabben. All rights reserved.
		</p>
	</div>
</body>
</html>