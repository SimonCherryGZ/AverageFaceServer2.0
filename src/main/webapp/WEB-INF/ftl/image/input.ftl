<#macro input>

    <style type="text/css">
        #inputbottom .bottom_div{background:#006cbf none repeat scroll 0 0;bottom:0;height:80px;margin:0 auto;opacity:1.0;overflow:hidden;padding:0;position:fixed;text-align:center;width:100%;z-index:100}
        #inputbottom .bottom_main{bottom:0;height:60px;margin:0 auto;overflow:hidden;padding:0;position:fixed;text-align:center;width:100%;z-index:9999}
        #inputbottom .bottom_con{display:inline-block;height:50px;margin:0 auto;width:1170px}
        #inputbottom .bottom_close{color:#080808;cursor:pointer;font-size:40px;font-weight:700;height:50px;position:absolute;right:15px;width:50px}
    </style>

    <div id="inputbottom">
        <div class="bottom_div">&nbsp;</div>
        <div class="bottom_main">
            <#--<p>Posted by: W3School</p>-->
            <#--<p>Contact information: <a href="mailto:someone@example.com">someone@example.com</a>.</p>-->
                <form id="formId" enctype="multipart/form-data" action="/image/grid.shtml" method="post">
                    <span style="color: #FFFFFF; ">图片路径 </span>
                    <label for="url">
                        <input type="text" id="url" name="url" placeholder="请输入图片路径" style="width:600px; height:20px;">
                    </label>
                    <input type="submit" value="Submit">
                </form>
        </div>
    </div>
</#macro>