package com.sojson.image.controller;

import com.sojson.common.controller.BaseController;
import com.sojson.common.model.UImage;
import com.sojson.common.model.UUser;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.image.service.GridService;
import com.sojson.user.service.UUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

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
}
