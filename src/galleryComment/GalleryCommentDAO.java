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
			//String dbURL = "jdbc:mysql://localhost/yhcyoon";
			//String dbID = "yhcyoon";
			//String dbPassword = "gmlcks5631!";
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
		ArrayList<GalleryComment> list = new ArrayList<GalleryComment>();
		String SQL = "SELECT * FROM galleryComment WHERE galleryID = ? AND galleryCommentAvailable = 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, galleryID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				GalleryComment galleryComment = new GalleryComment();
				galleryComment.setGalleryCommentID(rs.getInt(1));
				galleryComment.setGalleryID(rs.getInt(2));
				galleryComment.setUserID(rs.getString(3));
				galleryComment.setGalleryComment(rs.getString(4));
				galleryComment.setGalleryCommentDate(rs.getString(5));
				galleryComment.setGalleryCommentAvailable(rs.getInt(6));
				list.add(galleryComment);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}return list;
	}
	
	// galleryComment Action �Ҷ� galleryCommentAvailable = 0 ���� üũ�ϴ� �޼���
		public int checkGalleryCommentAvailable(int galleryCommentID) {
			PreparedStatement pstmt;
			ResultSet rs;
			String SQL = "SELECT galleryCommentAvailable FROM galleryComment WHERE galleryCommentID = ?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, galleryCommentID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;		// �����ͺ��̽� ����
		}
	
		// Ŀ�´�Ƽ ��� �����ϴ� �޼���
		public int updateGalleryComment(int galleryID, int galleryCommentID, String galleryComment) {
			PreparedStatement pstmt;
			String SQL = "UPDATE galleryComment SET galleryComment = ? WHERE galleryID = ? AND galleryCommentID = ?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, galleryComment);
				pstmt.setInt(2, galleryID);
				pstmt.setInt(3, galleryCommentID);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;	// �����ͺ��̽� ����
		}
		
		// Ŀ�´�Ƽ ��� �����ϴ� �޼���
		public int deleteGalleryComment(int galleryCommentID) {
			PreparedStatement pstmt;
			String SQL = "UPDATE galleryComment SET galleryCommentAvailable = 0 WHERE galleryCommentID = ?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, galleryCommentID);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;		// �����ͺ��̽� ����
		}
	
		// ������ ����� userID �������� �޼���
		public String getGalleryCommentUserID(int galleryCommentID) {
			PreparedStatement pstmt;
			ResultSet rs;
			String SQL = "SELECT userID FROM galleryComment WHERE galleryCommentID = ?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, galleryCommentID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
