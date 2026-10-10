package com.realestate;

import com.realestate.model.User;
import com.realestate.util.FileHandler;

public class TestFileHandler {
    public static void main(String[] args) {

        User user = new User(
                "U001",
                "kamal",
                "kamal@gmail.com",
                "1234",
                "Regular"
        );

        FileHandler.addUser(user);

        System.out.println("User saved successfully!");
    }
}
