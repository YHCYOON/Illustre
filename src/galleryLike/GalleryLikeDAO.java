package galleryLike;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GalleryLikeDAO {

	Connection conn;
	
	// MySQL 접속
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
	// 게시글에 이미 좋아요가 되어있는지 확인하는 메서드
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
				return rs.getInt(1);		// 0이면 좋아요 안되어있고 1이면 이미 좋아요인 상태
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	// 좋아요 +1 추가했을때 메서드
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
		return -1;		// 데이터베이스 오류
	}
	
	// 좋아요 -1 했을때 메서드
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
		return -1;		// 데이터베이스 오류
	}
	
	
	
	
	
	
	
	
	
	
	
}
