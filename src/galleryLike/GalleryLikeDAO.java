package galleryLike;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GalleryLikeDAO {

	Connection conn;
	
	// MySQL ����
	public GalleryLikeDAO() {
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
	// �Խñۿ� �̹� ���ƿ䰡 �Ǿ��ִ��� Ȯ���ϴ� �޼���
	public int checkLikeCount(String userID, int galleryID) {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT COUNT(*) FROM galleryLike WHERE userID = ? AND galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, galleryID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);		// 0�̸� ���ƿ� �ȵǾ��ְ� 1�̸� �̹� ���ƿ��� ����
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ����
	}
	
	// ���ƿ� +1 �߰������� �޼���
	public int galleryPlusLike(String userID, int galleryID) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO galleryLike VALUES(?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, galleryID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ����
	}
	
	// ���ƿ� -1 ������ �޼���
	public int galleryMinusLike(String userID, int galleryID) {
		PreparedStatement pstmt;
		String SQL = "DELETE FROM galleryLike WHERE userID = ? AND galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, galleryID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ����
	}
	
	
	
	
	
	
	
	
	
	
	
}
