package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	// MySQL 접속
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/Illustre";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 회원가입 메서드
	public int join(User user) {
		try {
			String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName()); 
			pstmt.setString(4, user.getUserNickname());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();		// 회원가입 완료
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// 이미 존재하는 아이디
	}
}
