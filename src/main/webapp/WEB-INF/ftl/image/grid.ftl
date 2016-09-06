<!DOCTYPE html>
<html lang="zh-cn" xmlns="http://www.w3.org/1999/html">

    <head>
        <meta charset="utf-8">
        <title>显示图片</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
        <link   rel="icon" href="http://img.wenyifan.net/images/favicon.ico" type="image/x-icon" />
        <link   rel="shortcut icon" href="http://img.wenyifan.net/images/favicon.ico" />
        <link href="/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
        <link href="/css/common/base.css?${_v}" rel="stylesheet"/>
        <script  src="/js/common/layer/layer.js"></script>
        <script  src="/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="/js/jquery-1.9.1.min.js"></script>
        <script src="/js/zoom.min.js"></script>
        <script src="/js/jqthumb.min.js"></script>
        <script>
                $(function(){
                    $('.element2 img').jqthumb({
                        width: 200,
                        height: 200,
                        after: function(imgObj){
                            imgObj.css('opacity', 0).animate({opacity: 1}, 1500);
                        }
                    });
                 });
        </script>

        <style type="text/css">
            body{overflow-y:scroll;font-family:"HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, sans-serif;background:#f4f4f4;padding:0;margin:0;}
            h1{font-size:31px;line-height:32px;font-weight:normal;margin-bottom:25px;}
            a,a:hover{border:none;text-decoration:none;}
            img,a img{border:none;}
            pre{overflow-x:scroll;background:#ffffff;border:1px solid #cecece;padding:10px;}
            .clear{clear:both;}
            .zoomed > .container2{-webkit-filter:blur(3px);filter:blur(3px);}
            .container2{width:1000px;margin:60px auto;}
            .gallery{list-style-type:none;float:left;}
            .gallery li{float:left;margin:10px; width:200px; height:200px;}
            .gallery li:nth-child(6n){padding-right:0;}
            .gallery li a,.gallery li img{float:left;}

            .element { width: 920px; margin: 0 auto; list-style-type: none; zoom: 1;}
            .element:after { content: ''; display: table; clear: both;}
            .element li { float: left; width: 200px; height: 200px; margin: 20px 10px 0; display: inline;}
            .element1 { border: 5px solid #d9534f;}
            .element1 img { width: 200px; height: 200px; vertical-align: top;}
            .element2 { border: 5px solid #5cb85c;}
        </style>
        <link rel="stylesheet"  href="/css/zoom.css" media="all" />
    </head>

    <body data-target="#one" data-spy="scroll">
        <@_top.top 1/>
        <div class="container2">
                <#if list?exists && list?size gt 0 >
                    <#list list as it>
                        <ul class="gallery">
                            <li class="element2">
                                <a href="${it.url}" style="width: 100%; height: 100%; background-image: url(${it.url}); background-size: cover; background-position: 50% 50%; background-repeat: no-repeat"></a>
                            </li>
                        </ul>
                    </#list>
                </#if>
            <div class="clear"></div>
        </div>
        <script src="/js/jquery-1.9.1.min.js"></script>
        <script src="/js/zoom.min.js"></script>
        <@_input.input/>
    </body>

</html>