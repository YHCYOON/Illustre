package gallery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GalleryDAO {
	
	Connection conn;
	
	// MySQL 접속
	public GalleryDAO() {
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
	
	// 현재 날짜와 시간 반환 메서드
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
			return null;	//데이터베이스 오류
		}
		
		// 갤러리 번호 반환 메서드 (현재 게시글 개수 +1 반환)
		public int getGalleryID() {
			PreparedStatement pstmt;
			ResultSet rs;
			String SQL = "SELECT galleryID FROM GALLERY ORDER BY galleryID DESC LIMIT 1";
			try {
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) +1 ;	// 현재 게시글 개수 +1
				}
				return 1;	// 현재가 첫번째 글인 경우
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	// 데이터베이스 오류
		}
	
	
	public int upload(String userID, String galleryCategory, String galleryTitle, String galleryContent, String fileName, String fileRealName) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO GALLERY VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getGalleryID());
			pstmt.setString(2, userID);
			pstmt.setString(3, galleryCategory);
			pstmt.setString(4, galleryTitle);
			pstmt.setString(5, galleryContent);
			pstmt.setString(6, getDate());
			pstmt.setString(7, fileName);
			pstmt.setString(8, fileRealName);
			pstmt.setInt(9, 0);	// galleryLikeCount = 1
			pstmt.setInt(10, 1);	// galleryAvailable = 1
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
}
