package galleryComment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GalleryCommentDAO {

Connection conn;
	
	// MySQL ����
	public GalleryCommentDAO() {
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
	public int getGalleryCommentID() {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT galleryCommentID FROM galleryComment ORDER BY galleryCommentID DESC LIMIT 1";
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
	
	// galleryComment �ۼ��ϴ� �޼���
	public int writeGalleryComment(int galleryID, String userID, String galleryComment) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO galleryComment VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getGalleryCommentID());
			pstmt.setInt(2, galleryID);
			pstmt.setString(3, userID);
			pstmt.setString(4, galleryComment);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);		// galleryCommentAvailable = 1
			return pstmt.executeUpdate();		// ������ 1 ��ȯ
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����ͺ��̽� ����
	}
	
	// galleryComment �������� �޼���
	public ArrayList<GalleryComment> getGalleryCommentList(int galleryID){
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT * FROM galleryComment WHERE galleryID = ? AND galleryCommentAvailable = 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, galleryID);
			rs = pstmt.executeQuery();
			ArrayList<GalleryComment> list = new ArrayList<GalleryComment>();
			while(rs.next()) {
				GalleryComment galleryComment = new GalleryComment();
				galleryComment.setGalleryCommentID(rs.getInt(1));
				galleryComment.setGalleryID(rs.getInt(2));
				galleryComment.setUserID(rs.getString(3));
				galleryComment.setGalleryComment(rs.getString(4));
				galleryComment.setGalleryCommentDate(rs.getString(5));
				galleryComment.setGalleryCommentAvailable(rs.getInt(6));
				list.add(galleryComment);
				return list;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
