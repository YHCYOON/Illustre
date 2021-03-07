package gallery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	// galleryRegist 메서드
	public int upload(String userID, String userNickname, String galleryCategory, String galleryTitle, String galleryContent, String fileName, String fileRealName) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO GALLERY VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getGalleryID());
			pstmt.setString(2, userID);
			pstmt.setString(3, userNickname);
			pstmt.setString(4, galleryCategory);
			pstmt.setString(5, galleryTitle);
			pstmt.setString(6, galleryContent);
			pstmt.setString(7, getDate());
			pstmt.setString(8, fileName);
			pstmt.setString(9, fileRealName);
			pstmt.setInt(10, 0);	// galleryLikeCount = 1
			pstmt.setInt(11, 1);	// galleryAvailable = 1
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	// gallery 총 게시글 개수를 가져오는 메서드
		public int countTotalPage(String galleryCategory, String keyWord, String searchWord) {
			PreparedStatement pstmt;
			ResultSet rs;
			String SQL_all = "SELECT COUNT(*) FROM GALLERY WHERE " + keyWord + " LIKE ? AND galleryAvailable = 1";
			String SQL_category = "SELECT COUNT(*) FROM GALLERY WHERE " + keyWord + " LIKE ? AND galleryCategory = ? AND galleryAvailable = 1";
			try {
				if(galleryCategory.equals("전체보기")) {
					pstmt = conn.prepareStatement(SQL_all);
					pstmt.setString(1, "%" + searchWord + "%");
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getInt(1);
					}
				}else {
					pstmt = conn.prepareStatement(SQL_category);
					pstmt.setString(1, "%" + searchWord + "%");
					pstmt.setString(2, galleryCategory);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getInt(1);
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;	// 데이터베이스 오류 
		}
	
	// gallery 총 페이지 수를 반환하는 메서드 + 검색 기능 추가
	public int getTotalPage(String galleryCategory, String keyWord, String searchWord) {
		PreparedStatement pstmt;
		ResultSet rs;
		int countList = 25;	// 한 페이지에 나타내는 그림이 25개
		String SQL_all = "SELECT COUNT(*) FROM GALLERY WHERE " + keyWord + " LIKE ? AND galleryAvailable = 1";
		String SQL_category = "SELECT COUNT(*) FROM GALLERY WHERE " + keyWord + " LIKE ? AND galleryCategory = ? AND galleryAvailable = 1";
		try {
			if(galleryCategory.equals("전체보기")) {
				pstmt = conn.prepareStatement(SQL_all);
				pstmt.setString(1, "%" + searchWord + "%");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getInt(1) % countList == 0 ) {
						return rs.getInt(1) / countList;
					}else {
						return rs.getInt(1) / countList + 1;
					}
				}
			}else {
				pstmt = conn.prepareStatement(SQL_category);
				pstmt.setString(1, "%" + searchWord + "%");
				pstmt.setString(2, galleryCategory);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getInt(1) % countList == 0 ) {
						return rs.getInt(1) / countList;
					}else {
						return rs.getInt(1) / countList + 1;
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류 
	}
	
	// startPage 가져오는 메서드
	public int getStartPage(int pageNumber) {
		int startPage = ((pageNumber - 1) / 10) * 10 + 1 ;
		return startPage;
	}
	
	// endPage 가져오는 메서드
	public int getEndPage(int pageNumber, String galleryCategory, String keyWord, String searchWord) {
		int endPage = getStartPage(pageNumber) + 9;
		int totalPage = getTotalPage(galleryCategory, keyWord, searchWord);
		if(endPage > totalPage) {
			return totalPage;
		}
		return endPage;
	}
	
	// gallery 가져오는 메서드 + 검색기능 추가
	public ArrayList<Gallery> getGalleryList(int pageNumber, String galleryCategory, String keyWord, String searchWord){
		PreparedStatement pstmt;
		ResultSet rs;
		ArrayList<Gallery> list = new ArrayList<Gallery>();
		
		String SQL_all = "SELECT * FROM GALLERY WHERE galleryAvailable = 1 AND " + keyWord + " LIKE ? ORDER BY galleryID DESC LIMIT ?, ?";
		String SQL_category = "SELECT * FROM GALLERY WHERE galleryAvailable = 1 AND galleryCategory = ? AND " + keyWord + " LIKE ? ORDER BY galleryID DESC LIMIT ?, ?";
		
		try {
			if(galleryCategory.equals("전체보기")) {
				pstmt = conn.prepareStatement(SQL_all);
				pstmt.setString(1, "%"+searchWord+"%");
				pstmt.setInt(2, (pageNumber - 1)*25);
				pstmt.setInt(3, 25);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Gallery gallery = new Gallery();
					gallery.setGalleryID(rs.getInt(1));
					gallery.setUserID(rs.getString(2));
					gallery.setUserNickname(rs.getString(3));
					gallery.setGalleryCategory(rs.getString(4));
					gallery.setGalleryTitle(rs.getString(5));
					gallery.setGalleryContent(rs.getString(6));
					gallery.setGalleryDate(rs.getString(7));
					gallery.setFileName(rs.getString(8));
					gallery.setFileRealName(rs.getString(9));
					gallery.setGalleryLikeCount(rs.getInt(10));
					gallery.setGalleryAvailable(rs.getInt(11));
					list.add(gallery);
				}
			}else {
				pstmt = conn.prepareStatement(SQL_category);
				pstmt.setString(1, galleryCategory);
				pstmt.setString(2, "%"+searchWord+"%");
				pstmt.setInt(3, (pageNumber - 1)*25);
				pstmt.setInt(4, 25);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Gallery gallery = new Gallery();
					gallery.setGalleryID(rs.getInt(1));
					gallery.setUserID(rs.getString(2));
					gallery.setUserNickname(rs.getString(3));
					gallery.setGalleryCategory(rs.getString(4));
					gallery.setGalleryTitle(rs.getString(5));
					gallery.setGalleryContent(rs.getString(6));
					gallery.setGalleryDate(rs.getString(7));
					gallery.setFileName(rs.getString(8));
					gallery.setFileRealName(rs.getString(9));
					gallery.setGalleryLikeCount(rs.getInt(10));
					gallery.setGalleryAvailable(rs.getInt(11));
					list.add(gallery);
			}
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// galleryView 가져오는 메서드
	public Gallery getGalleryView(int galleryID) {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT * FROM GALLERY WHERE galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, galleryID);
			rs = pstmt.executeQuery();
			Gallery gallery = new Gallery();
			if(rs.next()) {
				gallery.setGalleryID(rs.getInt(1));
				gallery.setUserID(rs.getString(2));
				gallery.setUserNickname(rs.getString(3));
				gallery.setGalleryCategory(rs.getString(4));
				gallery.setGalleryTitle(rs.getString(5));
				gallery.setGalleryContent(rs.getString(6));
				gallery.setGalleryDate(rs.getString(7));
				gallery.setFileName(rs.getString(8));
				gallery.setFileRealName(rs.getString(9));
				gallery.setGalleryLikeCount(rs.getInt(10));
				gallery.setGalleryAvailable(rs.getInt(11));
				return gallery;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;	// 데이터베이스 오류
	}
	
	// 좋아요 눌렀을때 galleryLikeCount + 1 하는 메서드
	public int galleryPlusLike(int galleryID) {
		PreparedStatement pstmt;
		String SQL = "UPDATE GALLERY SET galleryLikeCount = galleryLikeCount+1 WHERE galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, galleryID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	// 좋아요 눌렀을때 galleryLikeCount - 1 하는 메서드
	public int galleryMinusLike(int galleryID) {
		PreparedStatement pstmt;
		String SQL = "UPDATE GALLERY SET galleryLikeCount = galleryLikeCount-1 WHERE galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, galleryID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	// gallery Action 할때 galleryAvailable = 0 인지 체크하는 메서드
	public int checkGalleryAvailable(int galleryID) {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT galleryAvailable FROM gallery WHERE galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, galleryID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	// gallery 수정 메서드
	public int updateGallery(int galleryID, String galleryCategory, String galleryTitle, String galleryContent, String fileName, String fileRealName) {
		PreparedStatement pstmt;
		String SQL = "UPDATE GALLERY SET galleryCategory = ? , galleryTitle = ?, galleryContent = ? , fileName = ? , fileRealName = ? WHERE galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, galleryCategory);
			pstmt.setString(2, galleryTitle);
			pstmt.setString(3, galleryContent);
			pstmt.setString(4, fileName);
			pstmt.setString(5, fileRealName);
			pstmt.setInt(6, galleryID);
			return pstmt.executeUpdate();		// 성공시 1 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
	
	// gallery 삭제 메서드 
	public int deleteGallery(int galleryID) {
		PreparedStatement pstmt;
		String SQL = "UPDATE GALLERY SET galleryAvailable = ? WHERE galleryID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, galleryID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	// Ranking 페이지 gallery가져오는 메서드
	public ArrayList<Gallery> getRanking(String category) {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL_ALL = "SELECT * FROM gallery WHERE galleryAvailable = 1 ORDER BY galleryLikeCount DESC LIMIT ? , ?"; 
		String SQL = "SELECT * FROM gallery WHERE galleryCategory = ? AND galleryAvailable = 1 ORDER BY galleryLikeCount DESC LIMIT ? , ?";
		ArrayList<Gallery> list = new ArrayList<Gallery>();
		try {
			if(category.equals("전체보기")) {
				pstmt = conn.prepareStatement(SQL_ALL);
				pstmt.setInt(1, 0);
				pstmt.setInt(2, 28);		// likeCount가 높은 순으로 28개 가져옴
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Gallery gallery = new Gallery();
					gallery.setGalleryID(rs.getInt(1));
					gallery.setUserID(rs.getString(2));
					gallery.setUserNickname(rs.getString(3));
					gallery.setGalleryCategory(rs.getString(4));
					gallery.setGalleryTitle(rs.getString(5));
					gallery.setGalleryContent(rs.getString(6));
					gallery.setGalleryDate(rs.getString(7));
					gallery.setFileName(rs.getString(8));
					gallery.setFileRealName(rs.getString(9));
					gallery.setGalleryLikeCount(rs.getInt(10));
					gallery.setGalleryAvailable(rs.getInt(11));
					list.add(gallery);
				}
			}else {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, category);
				pstmt.setInt(2, 0);
				pstmt.setInt(3, 28);		// likeCount가 높은 순으로 28개 가져옴
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Gallery gallery = new Gallery();
					gallery.setGalleryID(rs.getInt(1));
					gallery.setUserID(rs.getString(2));
					gallery.setUserNickname(rs.getString(3));
					gallery.setGalleryCategory(rs.getString(4));
					gallery.setGalleryTitle(rs.getString(5));
					gallery.setGalleryContent(rs.getString(6));
					gallery.setGalleryDate(rs.getString(7));
					gallery.setFileName(rs.getString(8));
					gallery.setFileRealName(rs.getString(9));
					gallery.setGalleryLikeCount(rs.getInt(10));
					gallery.setGalleryAvailable(rs.getInt(11));
					list.add(gallery);
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	
	
	
	
}