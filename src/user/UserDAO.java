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
	// ���̵� �ߺ� üũ �޼���
	public int userIDCheck(String userID) {
		String SQL = "SELECT userID FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 1;	// �̹� �ִ� ���̵�
			}
			return 0;	// ��� ������ ���̵�
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����ͺ��̽� ����	
	}
	
	// �г��� �ߺ� üũ �޼���
	public int userNicknameCheck(String userNickname) {
		String SQL = "SELECT userNickname FROM USER WHERE userNickname = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userNickname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 1;	// �̹� �ִ� �г��� - �����Ұ�
			}
			return 0;	// ��� ������ �г��� - ��������
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����ͺ��̽� ����	
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

	// �г��� ���� �޼���
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
		return "";	// �����ͺ��̽� ����
	}
	
	// ȸ������ ���� �޼���
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
	
	// ȸ������ ���� �޼���
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
				return 1;	// ���� �Ϸ�
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ���� - �̹� �����ϴ� �г���
	}
	// ��й�ȣ ã�� �޼���
	public String getPassword(String userID, String userName, String userEmail) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ? AND userName = ? AND userEmail = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userName);
			pstmt.setString(3, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);		// ȸ�� ��й�ȣ ��ȯ
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "��ϵ� ������ �����ϴ�";	//��ġ�ϴ� ���̵� ����
	}
	
}
