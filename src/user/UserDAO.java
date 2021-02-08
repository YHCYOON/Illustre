package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	Connection conn;
	
	// MySQL ����
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
	
	// ȸ������ �޼���
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		PreparedStatement pstmt;
		try {	
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName()); 
			pstmt.setString(4, user.getUserNickname());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();		// ȸ������ �Ϸ� - 0�̻��� ���� ����
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// �̹� �����ϴ� ���̵�
	}
	
	// �α��� �޼���
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		PreparedStatement pstmt;
		ResultSet rs;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;	// �α��� ����
				}else {
					return 0;	// ��й�ȣ ����ġ
				}	
			}else {
				return -1;	// ���̵� ����
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2;	// �����ͺ��̽� ����
	}

	// �г��� ���� �޼���
	public String getNickname(String userID, String userPassword) {
		String SQL = "SELECT userNickname FROM USER WHERE userID = ? AND userPassword = ?";
		
		PreparedStatement pstmt;
		ResultSet rs;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";	// �����ͺ��̽� ����
	}
}
