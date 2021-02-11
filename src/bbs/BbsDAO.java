package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {

	Connection conn;
	
	// MySQL ����
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/Illustre";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// ���� ��¥�� �ð� ��ȯ �޼���
	public String getDate() {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT NOW()";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;	//�����ͺ��̽� ����
	}
	
	// �� ��ȣ ��ȯ �޼��� (���� �Խñ� ���� +1 ��ȯ)
	public int getBbsID() {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC LIMIT 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) +1 ;	// ���� �Խñ� ���� +1
			}
			return 1;	// ���簡 ù��° ���� ���
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ����
	}
	
	// �۾��� �޼���
	public int write(String bbsTitle, String bbsContent, String userID) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getBbsID());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, bbsContent);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����ͺ��̽� ����
	}
}
