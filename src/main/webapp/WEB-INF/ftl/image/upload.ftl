<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="A basic demo of Cropper.">
    <meta name="keywords" content="HTML, CSS, JS, JavaScript, jQuery plugin, image cropping, image crop, image move, image zoom, image rotate, image scale, front-end, frontend, web development">
    <meta name="author" content="Fengyuan Chen">
    <title>Cropper</title>
    <link rel="stylesheet" href="/css/cropper/font-awesome.min.css">
    <link rel="stylesheet" href="/css/cropper/bootstrap.min.css">
    <link rel="stylesheet" href="/css/cropper/cropper.css">
    <link rel="stylesheet" href="/css/cropper/main.css">
    <link rel="stylesheet" href="/css/dropzone.css">
    <link href="/css/common/base.css?${_v}" rel="stylesheet"/>

    <style type="text/css">
        .drag {
            display: block;
            width:150px;
            height:150px;
            float:left;
            /*position:fixed;*/
            /*bottom:0;*/
            /*margin:0 0 60px 0*/
        }
        .dropzone {
            padding: 0;
        }
    </style>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<!--[if lt IE 8]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->

<@_top.top 1/>
<!-- Content -->
<div class="container" style="margin-left: 60px; margin-top: 30px; float: left; width: 600px">
    <div class="row">
        <div class="col-md-9">
            <!-- <h3 class="page-header">Demo:</h3> -->
            <div class="img-container">
                <img id="image" src="/images/picture.jpg" alt="Picture">
            </div>
        </div>
        <#--<div class="col-md-3">-->
            <#--<div class="docs-preview clearfix">-->
                <#--<div class="img-preview preview-lg"></div>-->
            <#--</div>-->
            <#--<div class="input-group input-group-sm docs-toggles">-->
                <#--<div class="btn-group btn-group-justified" data-toggle="buttons"></div>-->
            <#--</div>-->
        <#--</div>-->

        <!-- <h3 class="page-header">Data:</h3> -->
        <div class="row">
            <div class="col-md-9 docs-buttons" style="margin-top: 20px; margin-left: 15px">
                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="setDragMode" data-option="move" title="Move">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;setDragMode&quot;, &quot;move&quot;)">
                          <span class="fa fa-arrows"></span>
                        </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="setDragMode" data-option="crop" title="Crop">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;setDragMode&quot;, &quot;crop&quot;)">
                          <span class="fa fa-crop"></span>
                        </span>
                    </button>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="zoom" data-option="0.1" title="Zoom In">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;zoom&quot;, 0.1)">
                          <span class="fa fa-search-plus"></span>
                        </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="zoom" data-option="-0.1" title="Zoom Out">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;zoom&quot;, -0.1)">
                          <span class="fa fa-search-minus"></span>
                        </span>
                    </button>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-45" title="Rotate Left">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;rotate&quot;, -45)">
                          <span class="fa fa-rotate-left"></span>
                        </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45" title="Rotate Right">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;rotate&quot;, 45)">
                          <span class="fa fa-rotate-right"></span>
                        </span>
                    </button>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="scaleX" data-option="-1" title="Flip Horizontal">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;scaleX&quot;, -1)">
                          <span class="fa fa-arrows-h"></span>
                        </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="scaleY" data-option="-1" title="Flip Vertical">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;scaleY&quot;-1)">
                          <span class="fa fa-arrows-v"></span>
                        </span>
                    </button>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="reset" title="Reset">
                        <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;reset&quot;)">
                          <span class="fa fa-refresh"></span>
                        </span>
                    </button>
                </div>

                <!-- Show the cropped image in modal -->
                <div class="modal fade docs-cropped" id="getCroppedCanvasModal" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle" role="dialog" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="getCroppedCanvasTitle">Cropped</h4>
                            </div>
                            <div class="modal-body"></div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <a class="btn btn-primary" id="download" href="javascript:void(0);" download="cropped.jpg">Download</a>
                            </div>
                        </div>
                    </div>
                </div><!-- /.modal -->
            </div>
        </div>
            <div class="btn-group" style="margin-top: 10px; margin-left: 15px; width: 640px">
                <label class="btn btn-primary btn-upload" for="inputImage" title="Upload image file">
                    <input type="file" class="sr-only" id="inputImage" name="file" accept="image/*">
                    <span class="docs-tooltip" data-toggle="tooltip" title="Import image with Blob URLs">
                      <span class="fa fa-upload"></span>
                    </span>
                </label>
                <form id="formId" action="" method="post">
                    <label for="url">
                        <input type="text" id="url" name="url" class="url" placeholder=" 输入图片URL" style="width:460px; height:34px;">
                    </label>
                    <input type="submit" id="upload" value="上传" style="height: 34px">
                    <span style="color: #181818; margin-left: 10px"> OR </span>
                </form>
            </div>

    </div>
</div>

<div class="col-md-3" style="margin-top: 30px; float: left">
    <div class="docs-preview clearfix">
        <div class="img-preview preview-lg"></div>
    </div>
    <div style="height: 120px">
        <span style="color: #181818; margin-left: 10px"> 确定 </span>
    </div>
    <div class="drag">
        <form action="/image/drag.shtml" enctype="multipart/form-data" method="post" id="my-dropzone" class="dropzone">
            <div class="fallback">
                <input type="file" name="file" multiple/>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="docs-footer">
    <div class="container">
        <p class="heart"></p>
    </div>
</footer>

<!-- Scripts -->
<script src="/js/cropper/jquery.min.js"></script>
<script src="/js/cropper/bootstrap.min.js"></script>
<script src="/js/cropper/cropper.js"></script>
<script src="/js/cropper/main.js"></script>
<script src="/js/dropzone.js"></script>
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
            this.on('addedfile', function() {
                if (typeof prevFile !== "undefined") {
                    this.removeFile(prevFile);
                }
            });
            this.on('success', function(file, responseText) {
                prevFile = file;
                window.location.reload(true);
            });
        }
    };
    Dropzone.prototype.defaultOptions.dictDefaultMessage = "拖拽图片到这里上传";
</script>
</body>
</html>
