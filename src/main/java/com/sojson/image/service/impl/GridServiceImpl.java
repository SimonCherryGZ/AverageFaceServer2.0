package com.sojson.image.service.impl;

import com.sojson.common.dao.UImageMapper;
import com.sojson.common.model.UImage;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.image.service.GridService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

/**
 * Created by Simon on 2016/8/30.
 */
@Service
public class GridServiceImpl extends BaseMybatisDao<UImageMapper> implements GridService{

    @Autowired
    UImageMapper uImageMapper;

    @Override
    public int insert(UImage image) {
        return uImageMapper.insert(image);
    }

    @Override
    public UImage selectByPrimaryKey(Long id) {
        return uImageMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<UImage> findImageByUserId(Long userId) {
        return uImageMapper.findImageByUserId(userId);
    }
}
