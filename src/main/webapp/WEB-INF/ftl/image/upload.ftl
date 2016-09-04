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


<p>
    This is the most minimal example of Dropzone. The upload in this example
    doesn't work, because there is no actual server to handle the file upload.
</p>

<!-- Change /upload-target to your upload address -->
<form action="/image/upload.shtml" enctype="multipart/form-data" method="post" class="dropzone">
    <div class="fallback">
        <input type="file" name="file" multiple/>
    </div>
</form>