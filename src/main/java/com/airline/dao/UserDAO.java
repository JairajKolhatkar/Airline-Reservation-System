package com.airline.dao;

import com.airline.models.User;
import com.airline.utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    // Method to register a new user
    public boolean registerUser(User user) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "INSERT INTO users (username, password, email, first_name, last_name, phone) VALUES (?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getFirstName());
            statement.setString(5, user.getLastName());
            statement.setString(6, user.getPhone());
            
            int rowsAffected = statement.executeUpdate();
            result = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return result;
    }
    
    // Method to check if username already exists
    public boolean isUsernameExists(String username) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        boolean exists = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT COUNT(*) FROM users WHERE username = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, username);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                exists = resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, statement, resultSet);
        }
        
        return exists;
    }
    
    // Method to check if email already exists
    public boolean isEmailExists(String email) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        boolean exists = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT COUNT(*) FROM users WHERE email = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                exists = resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, statement, resultSet);
        }
        
        return exists;
    }
    
    // Method to authenticate user
    public User login(String username, String password) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        User user = null;
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setPhone(resultSet.getString("phone"));
                user.setAdmin(resultSet.getBoolean("is_admin"));
                user.setCreatedAt(resultSet.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, statement, resultSet);
        }
        
        return user;
    }
    
    // Method to get user by ID
    public User getUserById(int userId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        User user = null;
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT * FROM users WHERE user_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, userId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setPhone(resultSet.getString("phone"));
                user.setAdmin(resultSet.getBoolean("is_admin"));
                user.setCreatedAt(resultSet.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, statement, resultSet);
        }
        
        return user;
    }
    
    // Method to update user profile
    public boolean updateUser(User user) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "UPDATE users SET first_name = ?, last_name = ?, email = ?, phone = ? WHERE user_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getPhone());
            statement.setInt(5, user.getUserId());
            
            int rowsAffected = statement.executeUpdate();
            result = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return result;
    }
    
    // Method to change password
    public boolean changePassword(int userId, String newPassword) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "UPDATE users SET password = ? WHERE user_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, newPassword);
            statement.setInt(2, userId);
            
            int rowsAffected = statement.executeUpdate();
            result = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return result;
    }
    
    // Method to get all users (Admin)
    public List<User> getAllUsers() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        List<User> users = new ArrayList<>();
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT * FROM users WHERE is_admin = false";
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            
            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setPhone(resultSet.getString("phone"));
                user.setAdmin(resultSet.getBoolean("is_admin"));
                user.setCreatedAt(resultSet.getTimestamp("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, null, resultSet);
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return users;
    }

    /**
     * Get total number of registered users
     * @return Number of users
     */
    public int getTotalUsersCount() throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) as count FROM users";
            
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return resultSet.getInt("count");
            }
            
            return 0;
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
    }
} 