package com.sojson.common.dao;

import com.sojson.common.model.UImage;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by Simon on 2016/8/29.
 */
@Repository
public interface UImageMapper {

//    int deleteByPrimaryKey(Long id);

    int insert(UImage image);

//    int insertSelective(UImage image);

    UImage selectByPrimaryKey(Long id);

//    int updateByPrimaryKeySelective(UImage image);

//    int updateByPrimaryKey(UImage image);

//    Map<String, Object> deleteImageById(String ids);

    List<UImage> findImageByUserId(Long userId);

//    List<UImage> findNowAllImage();
}
