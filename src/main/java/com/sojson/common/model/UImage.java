package com.sojson.common.model;

import java.io.Serializable;

/**
 * Created by Simon on 2016/8/29.
 */
public class UImage implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private Long uid;
    private String name;
    private String url;

    public UImage() {}
    public UImage(UImage image) {
        this.id = image.getId();
        this.uid = image.getUid();
        this.name = image.getName();
        this.url = image.getUrl();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "UImage{" +
                "id=" + id +
                ", uid=" + uid +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
