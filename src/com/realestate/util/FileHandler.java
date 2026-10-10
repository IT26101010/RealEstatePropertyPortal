package com.realestate.util;

import com.realestate.model.User;

import java.util.ArrayList;
import java.util.List;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class FileHandler {

    private static final String FILE_NAME =
            "C:\\Users\\NGC\\Desktop\\Y1S2\\OOP\\Project\\OOP Project\\Real Estate Property Listing Portal\\users.txt";


    public static void addUser(User user) {

        try (FileWriter writer = new FileWriter(FILE_NAME, true)) {
            System.out.println("User record saved to: " + FILE_NAME);

            writer.write(user.getUserId() + ","
                    + user.getUsername() + ","
                    + user.getEmail() + ","
                    + user.getPassword() + ","
                    + user.getMembershipType()
                    + System.lineSeparator());

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static User findUser(String username, String password) {

        try {
            BufferedReader reader = new BufferedReader(
                    new FileReader(FILE_NAME)
            );

            String line;

            while ((line = reader.readLine()) != null) {

                String[] data = line.split(",");

                if (data.length == 5) {

                    String userId = data[0];
                    String storedUsername = data[1];
                    String email = data[2];
                    String storedPassword = data[3];
                    String membershipType = data[4];

                    if (storedUsername.equals(username)
                            && storedPassword.equals(password)) {

                        reader.close();

                        return new User(
                                userId,
                                storedUsername,
                                email,
                                storedPassword,
                                membershipType
                        );
                    }
                }
            }

            reader.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }
    public static User findUserById(String userId) {

        try {
            BufferedReader reader = new BufferedReader(
                    new FileReader(FILE_NAME)
            );

            String line;

            while ((line = reader.readLine()) != null) {

                String[] data = line.split(",");

                if (data.length == 5) {

                    String storedUserId = data[0];
                    String username = data[1];
                    String email = data[2];
                    String password = data[3];
                    String membershipType = data[4];

                    if (storedUserId.equals(userId)) {

                        reader.close();

                        return new User(
                                storedUserId,
                                username,
                                email,
                                password,
                                membershipType
                        );
                    }
                }
            }

            reader.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }


    public static boolean updateUser(User updatedUser) {

        java.io.File inputFile = new java.io.File(FILE_NAME);
        java.io.File tempFile = new java.io.File(
                inputFile.getParent(),
                "users_temp.txt"
        );

        boolean userFound = false;

        try (
                java.io.BufferedReader reader =
                        new java.io.BufferedReader(
                                new java.io.FileReader(inputFile));

                java.io.BufferedWriter writer =
                        new java.io.BufferedWriter(
                                new java.io.FileWriter(tempFile))
        ) {

            String line;

            while ((line = reader.readLine()) != null) {

                String[] data = line.split(",", -1);

                if (data.length == 5
                        && data[0].equals(updatedUser.getUserId())) {

                    writer.write(
                            updatedUser.getUserId() + ","
                                    + updatedUser.getUsername() + ","
                                    + updatedUser.getEmail() + ","
                                    + updatedUser.getPassword() + ","
                                    + updatedUser.getMembershipType()
                    );

                    userFound = true;

                } else {
                    writer.write(line);
                }

                writer.newLine();
            }

        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (!userFound) {
            tempFile.delete();
            return false;
        }

        try {
            java.nio.file.Files.move(
                    tempFile.toPath(),
                    inputFile.toPath(),
                    java.nio.file.StandardCopyOption.REPLACE_EXISTING
            );

            return true;

        } catch (IOException e) {
            e.printStackTrace();
            tempFile.delete();
            return false;
        }
    }


    public static boolean deleteUser(String userId) {

        java.io.File inputFile = new java.io.File(FILE_NAME);

        java.io.File tempFile = new java.io.File(
                inputFile.getParent(),
                "users_temp.txt"
        );

        boolean userFound = false;

        try (
                java.io.BufferedReader reader =
                        new java.io.BufferedReader(
                                new java.io.FileReader(inputFile));

                java.io.BufferedWriter writer =
                        new java.io.BufferedWriter(
                                new java.io.FileWriter(tempFile))
        ) {

            String line;

            while ((line = reader.readLine()) != null) {

                String[] data = line.split(",", -1);

                if (data.length == 5 && data[0].equals(userId)) {

                    userFound = true;

                } else {

                    writer.write(line);
                    writer.newLine();

                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            tempFile.delete();
            return false;
        }

        if (!userFound) {
            tempFile.delete();
            return false;
        }

        try {

            java.nio.file.Files.move(
                    tempFile.toPath(),
                    inputFile.toPath(),
                    java.nio.file.StandardCopyOption.REPLACE_EXISTING
            );

            return true;

        } catch (IOException e) {
            e.printStackTrace();
            tempFile.delete();
            return false;
        }
    }

    public static User findUserByUsername(String username) {

        try (BufferedReader reader =
                     new BufferedReader(new FileReader(FILE_NAME))) {

            String line;

            while ((line = reader.readLine()) != null) {

                String[] data = line.split(",", -1);

                if (data.length >= 5 &&
                        data[1].equalsIgnoreCase(username)) {

                    return new User(
                            data[0],
                            data[1],
                            data[2],
                            data[3],
                            data[4]
                    );
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        try (BufferedReader reader =
                     new BufferedReader(new FileReader(FILE_NAME))) {

            String line;

            while ((line = reader.readLine()) != null) {

                String[] data = line.split(",", -1);

                if (data.length >= 5) {

                    User user = new User(
                            data[0],
                            data[1],
                            data[2],
                            data[3],
                            data[4]
                    );

                    users.add(user);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return users;
    }


}