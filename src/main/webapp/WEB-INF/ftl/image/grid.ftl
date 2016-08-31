<!DOCTYPE html>
<html lang="zh-cn">

    <head>
        <meta charset="utf-8">
        <title>显示图片</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
        <link   rel="icon" href="http://img.wenyifan.net/images/favicon.ico" type="image/x-icon" />
        <link   rel="shortcut icon" href="http://img.wenyifan.net/images/favicon.ico" />
        <link href="/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
        <link href="/css/common/base.css?${_v}" rel="stylesheet"/>
        <script  src="http://open.sojson.com/common/jquery/jquery1.8.3.min.js"></script>
        <script  src="/js/common/layer/layer.js"></script>
        <script  src="/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
        <#--<script>-->
            <#--$(document).ready(function(){-->
                <#--$("img").click(function(){-->
                    <#--alert("点击了：" + $(this).attr("alt"));-->
                <#--});-->
            <#--});-->
        <#--</script>-->

        <style type="text/css">
            /*#grid ul{margin:0;padding:0}*/
            /*#grid li{width:200px; height:200px; border: 1px darkslateblue solid;list-style:none;float:left;margin:10px}*/
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
        </style>
        <link rel="stylesheet"  href="/css/zoom.css" media="all" />
    </head>

    <body data-target="#one" data-spy="scroll">
        <@_top.top 1/>
        <#--<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">-->
        <div class="container2">
            <#--<ul class="gallery">-->
                <#--<li><a href="http://www.wenzhanghui.com/article/page/game_single_strategy/20140225/040106516176.jpg"><img src="http://www.wenzhanghui.com/article/page/game_single_strategy/20140225/040106516176.jpg" height="200" width="200"/></a></li>-->
                <#--<li><a href="http://g.hiphotos.baidu.com/zhidao/pic/item/42a98226cffc1e17fc7430964890f603728de94a.jpg"><img src="http://g.hiphotos.baidu.com/zhidao/pic/item/42a98226cffc1e17fc7430964890f603728de94a.jpg" height="200" width="200"/></a></li>-->
                <#--<li><a href="http://cdn.u1.huluxia.com/g1/M00/CA/51/wKgBB1VWvYCAQlOfAAZldlZbX0c332.jpg"><img src="http://cdn.u1.huluxia.com/g1/M00/CA/51/wKgBB1VWvYCAQlOfAAZldlZbX0c332.jpg" height="200" width="200"/></a></li>-->
                <#--<li><a href="http://img1.pcgames.com.cn/pcgames/0710/20/967368_pcgames1019emcwp_02.jpg"><img src="http://img1.pcgames.com.cn/pcgames/0710/20/967368_pcgames1019emcwp_02.jpg" height="200" width="200"/></a></li>-->
                <#--<li><a href="http://www.wenzhanghui.com/article/page/game_single_strategy/20140225/040106516176.jpg"><img src="http://www.wenzhanghui.com/article/page/game_single_strategy/20140225/040106516176.jpg" height="200" width="200"/></a></li>-->
                <#--<li><a href="http://g.hiphotos.baidu.com/zhidao/pic/item/42a98226cffc1e17fc7430964890f603728de94a.jpg"><img src="http://g.hiphotos.baidu.com/zhidao/pic/item/42a98226cffc1e17fc7430964890f603728de94a.jpg" height="200" width="200"/></a></li>-->
                <#--<li><a href="http://cdn.u1.huluxia.com/g1/M00/CA/51/wKgBB1VWvYCAQlOfAAZldlZbX0c332.jpg"><img src="http://cdn.u1.huluxia.com/g1/M00/CA/51/wKgBB1VWvYCAQlOfAAZldlZbX0c332.jpg" height="200" width="200"/></a></li>-->
                <#--<li><a href="http://img1.pcgames.com.cn/pcgames/0710/20/967368_pcgames1019emcwp_02.jpg"><img src="http://img1.pcgames.com.cn/pcgames/0710/20/967368_pcgames1019emcwp_02.jpg" height="200" width="200"/></a></li>-->
            <#--</ul>-->
                <#if list?exists && list?size gt 0 >
                    <#list list as it>
                        <ul class="gallery">
                            <li><a href="${it.url}"><img src="${it.url}" height="200" width="200"/></a></li>
                        </ul>
                    </#list>
                </#if>
            <div class="clear"></div>
        </div>
        <script src="/js/jquery-1.9.1.min.js"></script>
        <script src="/js/zoom.min.js"></script>
    </body>

</html>