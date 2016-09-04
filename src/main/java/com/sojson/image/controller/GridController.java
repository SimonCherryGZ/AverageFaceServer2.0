package com.sojson.image.controller;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.UImage;
import com.sojson.common.model.UUser;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.image.service.GridService;
import com.sojson.user.service.UUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Simon on 2016/8/28.
 */
@Controller
@Scope(value="prototype")
@RequestMapping("image")
public class GridController extends BaseController {

    //设置好账号的ACCESS_KEY和SECRET_KEY
    String ACCESS_KEY = "oC2ZHh8ACTzYw1FxzGuqlhOEWd1kJ7mpSYCj5o3a";
    String SECRET_KEY = "SBIAL2rMvmMyo1m1fMlRdyPQd1F0hPDQLjGl8bj4";
    //要上传的空间
    String bucketname = "averageface";
    //上传到七牛后保存的文件名
    String key = "face.png";
    //上传文件的路径
    String FilePath = "D:/tmp/";
    //外链地址
    String QiNiuUrl = "http://oczduo6wo.bkt.clouddn.com/";

    @Autowired
    GridService gridService;
    @Autowired
    UUserService userService;

    //密钥配置
    Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
    //创建上传对象
    UploadManager uploadManager = new UploadManager();

    //设置callbackUrl以及callbackBody，七牛将文件名和文件大小回调给业务服务器
    private String getUpToken(String key){
//        return auth.uploadToken(bucketname,key,3600,new StringMap()
//                .put("callbackUrl","http://oczduo6wo.bkt.clouddn.com/callback")
//                .put("callbackBody", "filename=$(fname)&filesize=$(fsize)"));
        return auth.uploadToken(bucketname, key);
    }

    private void uploadToQiNiu(String path) throws IOException {
        try {
            String name = String.valueOf(System.currentTimeMillis()) + key;
            //调用put方法上传
            Response res = uploadManager.put(path, name, getUpToken(name));
            //打印返回的信息
            //System.out.println(res.bodyString());
            LoggerUtils.info(getClass(), res.bodyString());
            //图片外链地址插入数据库
            UUser currentUser =  userService.findUserByEmail(TokenManager.getToken().getEmail());
            UImage image = new UImage();
            image.setUrl(QiNiuUrl + name);
            image.setName(name);
            image.setUid(currentUser.getId());
            int result = gridService.insert(image);
            if (result > 0) {
                LoggerUtils.info(getClass(), "成功插入七牛外链地址到数据库");
            } else {
                LoggerUtils.info(getClass(), "插入七牛外链地址到数据库失败！");
            }

        } catch (QiniuException e) {
            Response r = e.response;
            // 请求失败时打印的异常信息
            System.out.println(r.toString());
            try {
                //响应的文本信息
                System.out.println(r.bodyString());
            } catch (QiniuException e1) {
                //ignore
            }
        }
    }


    @RequestMapping(value="grid",method= RequestMethod.GET)
    public ModelAndView grid(){
        List<UImage> imageList = new ArrayList<>();
        UUser currentUser =  userService.findUserByEmail(TokenManager.getToken().getEmail());
        if (currentUser != null) {
            imageList = gridService.findImageByUserId(currentUser.getId());
        }
        //List<UImage> imageList = gridService.findImageByUserId((long) 15);
        if (imageList != null && imageList.size() > 0) {
            System.out.println(imageList.toString());
        } else {
            System.out.println("no image exist");
        }
        return new ModelAndView("image/grid","list", imageList);
    }

    @RequestMapping(value="grid",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> insertImageUrl(String url){
        if (StringUtils.isNotBlank(url)) {
            UUser currentUser =  userService.findUserByEmail(TokenManager.getToken().getEmail());
            String name = String.valueOf(System.currentTimeMillis());
            UImage image = new UImage();
            image.setUrl(url);
            image.setName(name);
            image.setUid(currentUser.getId());
            int result = gridService.insert(image);
            if (result > 0) {
                resultMap.put("status", 200);
                resultMap.put("message", "保存图片路径成功!");
                return resultMap;
            }
        }
        resultMap.put("status", 300);
        resultMap.put("message", "图片路径为空！");
        return resultMap;
    }

    @RequestMapping(value = "drag", method = RequestMethod.GET)
    public ModelAndView drag() {
        return new ModelAndView("image/drag");
    }

    @RequestMapping(value = "drag", method = RequestMethod.POST)
    @ResponseBody
    public String drag2upload(@RequestParam("file")MultipartFile[] file)throws Exception{

        for(int i = 0 ; i < file.length; i++){
            if(!file[i].isEmpty()){
                //file[i].transferTo(new File("D:/tmp/" + file[i].getOriginalFilename()));
                file[i].transferTo(new File(FilePath + file[i].getOriginalFilename()));
                uploadToQiNiu(FilePath + file[i].getOriginalFilename());

            }else{
                LoggerUtils.info(getClass(), "failed to upload");
                return "failed to upload";
            }
        }
        LoggerUtils.info(getClass(), "upload successful");
        return "upload successful";
    }

    @RequestMapping(value = "upload", method = RequestMethod.GET)
    public ModelAndView upload() {
        return new ModelAndView("image/upload");
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @ResponseBody
    public String fileUpload(@RequestParam("file")MultipartFile[] file)throws Exception{

        for(int i = 0 ; i < file.length; i++){
            if(!file[i].isEmpty()){
                file[i].transferTo(new File("D:/tmp/" + file[i].getOriginalFilename()));

            }else{
                LoggerUtils.info(getClass(), "failed to upload");
                return "failed to upload";
            }
        }
        LoggerUtils.info(getClass(), "upload successful");
        return "upload successful";
    }

//
    public static HttpSession getSession() {
        HttpSession session = null;
        try {
            session = getRequest().getSession();
        } catch (Exception e) {}
        return session;
    }

    public static HttpServletRequest getRequest() {
        ServletRequestAttributes attrs =(ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attrs.getRequest();
    }
}
