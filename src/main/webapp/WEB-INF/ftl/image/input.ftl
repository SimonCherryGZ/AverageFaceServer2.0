<#macro input>

    <script src="/js/dropzone.js"></script>
    <link rel="stylesheet" href="/css/dropzone.css">

    <style type="text/css">
        #inputbottom .bottom_div{background:#006cbf none repeat scroll 0 0;bottom:0;height:60px;margin:0 auto;opacity:1.0;overflow:hidden;padding:0;position:fixed;text-align:center;width:100%;z-index:100}
        #inputbottom .bottom_main{bottom:0;height:40px;margin:0 auto;overflow:hidden;padding:0;position:fixed;text-align:center;width:100%;z-index:9999}
        #inputbottom .bottom_con{display:inline-block;height:50px;margin:0 auto;width:1170px}
        #inputbottom .bottom_close{color:#080808;cursor:pointer;font-size:40px;font-weight:700;height:50px;position:absolute;right:15px;width:50px}

        .drag {
            display: block;
            width:150px;
            height:150px;
            float:left;
            position:fixed;
            bottom:0;
            margin:0 0 60px 0
        }
        .dropzone {
            padding: 0;
        }
    </style>

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

    <#--<div id="inputbottom">-->
        <#--<div class="bottom_div">&nbsp;</div>-->
        <#--<div class="bottom_main">-->
            <#--&lt;#&ndash;<p>Posted by: W3School</p>&ndash;&gt;-->
            <#--&lt;#&ndash;<p>Contact information: <a href="mailto:someone@example.com">someone@example.com</a>.</p>&ndash;&gt;-->
                <#--<form id="formId" enctype="multipart/form-data" action="/image/grid.shtml" method="post">-->
                    <#--<span style="color: #FFFFFF; ">图片路径 </span>-->
                    <#--<label for="url">-->
                        <#--<input type="text" id="url" name="url" placeholder="请输入图片路径" style="width:400px; height:20px;">-->
                    <#--</label>-->
                    <#--<input type="submit" value="Submit">-->
                <#--</form>-->
        <#--</div>-->
    <#--</div>-->
<div class="drag">
    <form action="/image/drag.shtml" enctype="multipart/form-data" method="post" id="my-dropzone" class="dropzone">
        <div class="fallback">
            <input type="file" name="file" multiple/>
        </div>
    </form>
</div>

<div id="inputbottom">
    <div class="bottom_div">&nbsp;</div>
    <div class="bottom_main">

        <div style="float: left; margin-left: 20px">
            <#--<form id="formId" enctype="multipart/form-data" action="/image/grid.shtml" method="post">-->
                <#--<span style="color: #FFFFFF; ">or    输入图片路径  </span>-->
                <#--<label for="url">-->
                    <#--<input type="text" id="url" name="url" placeholder="" style="width:400px; height:20px;">-->
                <#--</label>-->
                <#--<input type="submit" value="上传">-->
            <#--</form>-->
                <form id="formId" action="" method="post">
                    <span style="color: #FFFFFF; ">or    输入图片路径  </span>
                    <label for="url">
                        <input type="text" id="url" name="url" class="url" placeholder="" style="width:400px; height:20px;">
                    </label>
                    <input type="submit" id="upload" value="上传">
                </form>
        </div>
    </div>
</div>

<script>
    jQuery(document).ready(function() {
        $('#upload').click(function(){
            var url = $('.url').val();
            var data = {url:url};
            var load = layer.load();
            $.post("/image/grid.shtml",data ,function(result){
                layer.close(load);
                if(result && result.status == 200){
                    layer.msg('上传成功！');
                    alert("上传成功");
                    window.location.reload(true);
                    //window.location.href="grid.shtml";
                }
            },"json");
            <#--$.ajax({-->
                <#--url:"/image/grid.shtml",-->
                <#--type:"post",-->
                <#--data:data,-->
                <#--success:function(result){-->
                    <#--alert("message-&ndash;&gt;" + result.message);-->
                <#--}-->
            <#--});-->
        <#--});-->
    <#--}-->
</script>

</#macro>