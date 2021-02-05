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
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {	
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName()); 
			pstmt.setString(4, user.getUserNickname());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();		// 회원가입 완료 - 0이상의 값을 리턴
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// 이미 존재하는 아이디
	}
	
	// 로그인 메서드
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;	// 로그인 성공
				}else {
					return 0;	// 비밀번호 불일치
				}	
			}else {
				return -1;	// 아이디가 없음
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2;	// 데이터베이스 오류
	}

	// 유저 회원정보 리턴 메서드
	public String[] getUserContent(String userID, String userPassword) {
		String SQL = "SELECT * FROM USER WHERE userID = ? AND userPassword = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			rs = pstmt.executeQuery();
			String userContent[] = new String[5];
			userContent[0] = rs.getString(1);
			userContent[1] = rs.getString(2);
			userContent[2] = rs.getString(3);
			userContent[3] = rs.getString(4);
			userContent[4] = rs.getString(5);
			return userContent;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;	// 데이터베이스 오류
	}
	
}
