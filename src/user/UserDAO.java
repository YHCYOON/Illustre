package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
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

	// ���� ȸ������ ���� �޼���
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
		return null;	// �����ͺ��̽� ����
	}
	
}
