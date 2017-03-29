package com.example.jeff_lu.chatapp;

/**
 * Created by jeff_lu on 2017/3/17.
 */
import java.util.HashMap;
import java.util.Map;

public class FriendlyMessage {

    private String id;
    private String text;
    private String name;
    private String photoUrl;
    private String imageUrl;
    private String UID;

    public FriendlyMessage() {
    }

    public FriendlyMessage(String text, String name, String photoUrl, String imageUrl, String UID) {
        this.text = text;
        this.name = name;
        this.photoUrl = photoUrl;
        this.imageUrl = imageUrl;
        this.UID = UID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public String getText() {
        return text;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getUID(){return UID;}

    public Map<String, Object> toMap(){
        HashMap<String, Object> result = new HashMap<>();
        result.put("text", this.text);
        result.put("name", this.name);
        result.put("photoUrl", this.photoUrl);
        result.put("imageUrl", this.imageUrl);
        result.put("UID", this.UID);

        return result;
    }
}

