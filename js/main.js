var curl = new ZeroClipboard( document.getElementById("curl-button") );

curl.on( "ready", function( readyEvent ) {
  // alert( "ZeroClipboard SWF is ready!" );

  curl.on( "aftercopy", function( event ) {
    // `this` === `curl`
    // `event.target` === the element that was clicked
    event.target.style.display = "none";
    alert("Copied text to clipboard: " + event.data["text/plain"] );
  } );
} );


var wget = new ZeroClipboard( document.getElementById("wget-button") );

wget.on( "ready", function( readyEvent ) {
  // alert( "ZeroClipboard SWF is ready!" );

  wget.on( "aftercopy", function( event ) {
    // `this` === `wget`
    // `event.target` === the element that was clicked
    event.target.style.display = "none";
    alert("Copied text to clipboard: " + event.data["text/plain"] );
  } );
} );
