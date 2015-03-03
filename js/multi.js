//<div class="mmlclip" title="MML@***,***,***;">ボタン</div>

window.onload = function() {
//	ZeroClipboard.setMoviePath("http://blog-imgs-47.fc2.com/b/l/o/blogfourthline/ZeroClipboard.swf");

	var elements = document.getElementsByTagName("div");
	for (var i = 0; i < elements.length; i++) {
		if (elements[i].className == "mmlclip") {
			var mml = elements[i].title;
			if (mml.match("^MML@") == null)
				continue;
			elements[i].title = "";
			elements[i].className = "clip_button";
			createClip6(elements[i], mml);
		}
	}


	//createClip(<copy button element>, <mml text>)
	function createClip6(element, text) {
		var clip = new ZeroClipboard.Client( element );
	
		clip.setHandCursor( true );
		clip.setText( text );
		clip.addEventListener('complete', mmlClipComplete);
	}
	
	function mmlClipComplete(client, text) {
		alert("クリップボードにコピーしました。");
	}

};
