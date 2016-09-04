<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <div id="drop_area" style="width:300px;height:200px;background:#fcc;"></div>
        <div id="preview"></div>
        <script>
            //阻止默认事件
            window.onload = function(){
                //拖离
                document.addEventListener('dragleave',function(e){e.preventDefault();});
                //拖后放
                document.addEventListener('drop',function(e){e.preventDefault();});
                //拖进
                document.addEventListener('dragenter',function(e){e.preventDefault();});
                //拖来拖去
                document.addEventListener('dragover',function(e){e.preventDefault();});
                var box = document.getElementById('drop_area'); //拖拽区域
                box.addEventListener("drop",function(e){
                    e.preventDefault(); //取消默认浏览器拖拽效果
                    var fileList = e.dataTransfer.files; //获取文件对象
                    //检测是否是拖拽文件到页面的操作
                    if(fileList.length == 0){return false;}
                    //检测文件是不是图片
                    if(fileList[0].type.indexOf('image') === -1){
                        alert("您拖的不是图片！");
                        return false;
                    }
                    //拖拉图片到浏览器，可以实现预览功能
                    var img = window.webkitURL.createObjectURL(fileList[0]);
                    var filename = fileList[0].name; //图片名称
                    var filesize = Math.floor((fileList[0].size)/1024);
                    if(filesize>500){
                        alert("上传大小不能超过500K.");
                        return false;
                    }
                    var image = document.createElement('img');
                    image.src = img;
                    var p = document.createElement("p");
                    p.innerHTML = "图片名称："+filename+"<br/>大小："+filesize+"KB";
                    document.getElementById("preview").appendChild(image);
                    document.getElementById("preview").appendChild(p);
                    //上传
                    xhr = new XMLHttpRequest();
                    xhr.open("post", "/image/drag", true);
                    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

                    var fd = new FormData();
                    fd.append('mypic', fileList[0]);
                    xhr.send(fd);
                },false);
            };
        </script>
    </body>
</html>