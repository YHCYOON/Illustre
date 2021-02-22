package bbsComment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsCommentDAO {

Connection conn;
	
	// MySQL ����
	public BbsCommentDAO() {
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
	
	// ��� ��ȣ �������� �޼���
	public int getBbsCommentID() {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT bbsCommentID FROM bbsComment ORDER BY bbsCommentID DESC LIMIT 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}else {
				return 1;		// ����� ������
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ����
	}
	
	// Ŀ�´�Ƽ ��� ��� �޼���
	public int writeBbsComment(int bbsID, String userID, String bbsComment) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO BBSCOMMENT VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getBbsCommentID());
			pstmt.setInt(2, bbsID);
			pstmt.setString(3, userID);
			pstmt.setString(4, bbsComment);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();		// ������ 1 ��ȯ
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����ͺ��̽� ����
	}
		
	// Ŀ�´�Ƽ ��� ���� �������� �޼���
	public ArrayList<BbsComment> getBbsComment(int bbsID){
		PreparedStatement pstmt;
		ResultSet rs;
		ArrayList<BbsComment> list = new ArrayList<BbsComment>();
		String SQL = "SELECT * FROM bbsComment WHERE bbsID = ? AND bbsAvailable = 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BbsComment bbsComment = new BbsComment();
				bbsComment.setBbsCommentID(rs.getInt(1));
				bbsComment.setBbsID(rs.getInt(2));
				bbsComment.setUserID(rs.getString(3));
				bbsComment.setBbsComment(rs.getString(4));
				bbsComment.setBbsCommentDate(rs.getString(5));
				bbsComment.setBbsAvailable(rs.getInt(6));
				list.add(bbsComment);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// Ŀ�´�Ƽ ��� �����ϴ� �޼���
	public int updateBbsComment(int bbsID, int bbsCommentID, String bbsComment) {
		PreparedStatement pstmt;
		String SQL = "UPDATE bbsComment SET bbsComment = ? WHERE bbsID = ? AND bbsCommentID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsComment);
			pstmt.setInt(2, bbsID);
			pstmt.setInt(3, bbsCommentID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ����
	}
	
}
