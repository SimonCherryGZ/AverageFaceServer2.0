<!DOCTYPE html>

<meta charset="utf-8">

<title>Dropzone simple example</title>


<!--
  DO NOT SIMPLY COPY THOSE LINES. Download the JS and CSS files from the
  latest release (https://github.com/enyo/dropzone/releases/latest), and
  host them yourself!
-->
<script src="/js/dropzone.js"></script>
<link rel="stylesheet" href="/css/dropzone.css">

<style>
    .upload {
        display: block;
        width:150px;
        height:150px;
    }
    .dropzone {
        padding: 0;
    }
</style>


<p>
    This is the most minimal example of Dropzone. The upload in this example
    doesn't work, because there is no actual server to handle the file upload.
</p>

<div class="dropz"></div>
<script>
    // myDropzone is the configuration for the element that has an id attribute
    // with the value my-dropzone (or myDropzone)
    Dropzone.options.myDropzone = {
        maxFiles: 1,
        init: function() {
            var prevFile;

            this.on("maxfilesexceeded", function(file) {
                this.removeFile(file);
            });
//            this.on('addedfile', function() {
//                if (typeof prevFile !== "undefined") {
//                    this.removeFile(prevFile);
//                }
//            });
            this.on('success', function(file, responseText) {
//                prevFile = file;
                this.removeFile(file);
            });
        }
    };
</script>

<div class="upload">
<form action="/image/drag.shtml" enctype="multipart/form-data" method="post" id="my-dropzone" class="dropzone">
    <div class="fallback">
        <input type="file" name="file" multiple/>
    </div>
</form>
</div>