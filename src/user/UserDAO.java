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
	// 아이디 중복 체크 메서드
	public int userIDCheck(String userID) {
		String SQL = "SELECT userID FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 1;	// 이미 있는 아이디
			}
			return 0;	// 사용 가능한 아이디
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류	
	}
	
	// 닉네임 중복 체크 메서드
	public int userNicknameCheck(String userNickname) {
		String SQL = "SELECT userNickname FROM USER WHERE userNickname = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userNickname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 1;	// 이미 있는 닉네임 - 수정불가
			}
			return 0;	// 사용 가능한 닉네임 - 수정가능
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류	
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

	// 닉네임 리턴 메서드
	public String getNickname(String userID) {
		String SQL = "SELECT userNickname FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";	// 데이터베이스 오류
	}
	
	// 회원정보 리턴 메서드
	public User getUserInfo(String userID) {
		String SQL = "SELECT * FROM USER WHERE userID = ? ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if( rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserNickname(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				return user;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 회원정보 수정 메서드
	public int updateUserInfo(User user) {
		String SQL = "UPDATE USER SET userPassword = ?, userName = ?, userNickname = ?, userEmail = ? WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserPassword());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserNickname());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserID());
			int result = pstmt.executeUpdate();
			if ( result != 0) {
				return 1;	// 수정 완료
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류 - 이미 존재하는 닉네임
	}
	// 비밀번호 찾기 메서드
	public String getPassword(String userID, String userName, String userEmail) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ? AND userName = ? AND userEmail = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userName);
			pstmt.setString(3, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);		// 회원 비밀번호 반환
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "등록된 정보가 없습니다";	//일치하는 아이디 없음
	}
	
}
