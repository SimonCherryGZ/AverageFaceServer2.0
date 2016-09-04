package com.sojson.image.controller;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
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

    @Autowired
    GridService gridService;
    @Autowired
    UUserService userService;

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

}
