package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	

	// �Խñ� ����Ʈ �����ֱ� �޼���
	public ArrayList<Bbs> getBbsList(int pageNumber){
		PreparedStatement pstmt;
		ResultSet rs;
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getBbsID() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsLikeCount(rs.getInt(6));
				bbs.setBbsAvailable(rs.getInt(7));
				list.add(bbs);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// �Խñ� view �޼���
	public Bbs getBbs(int bbsID) {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			Bbs bbs = new Bbs();
			if(rs.next()) {
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsLikeCount(rs.getInt(6));
				bbs.setBbsAvailable(rs.getInt(7));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// �Խñ� delete �޼���
	public int deleteBbs(int bbsID) {
		PreparedStatement pstmt;
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();		// ������ 1 ��ȯ
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����ͺ��̽� ����
	}
	
	// �Խñ� ���� �޼���
	public int updateBbs(int bbsID, String bbsTitle, String bbsContent) {
		PreparedStatement pstmt;
		String SQL = "UPDATE BBS SET bbsTitle = ? , bbsContent = ? WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();		// ������ 1 ��ȯ
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����ͺ��̽� ����
	}
}
