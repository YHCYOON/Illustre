package gallery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GalleryDAO {
	
	Connection conn;
	
	// MySQL ����
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
		
		// ������ ��ȣ ��ȯ �޼��� (���� �Խñ� ���� +1 ��ȯ)
		public int getGalleryID() {
			PreparedStatement pstmt;
			ResultSet rs;
			String SQL = "SELECT galleryID FROM GALLERY ORDER BY galleryID DESC LIMIT 1";
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
	
	// galleryRegist �޼���
	public int upload(String userNickname, String galleryCategory, String galleryTitle, String galleryContent, String fileName, String fileRealName) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO GALLERY VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getGalleryID());
			pstmt.setString(2, userNickname);
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
		return -1;	// �����ͺ��̽� ����
	}
	
	// gallery �� ������ ���� ��ȯ�ϴ� �޼��� + �˻� ��� �߰�
	public int getTotalPage(String galleryCategory, String keyWord, String searchWord) {
		PreparedStatement pstmt;
		ResultSet rs;
		int countList = 25;	// �� �������� ��Ÿ���� �׸��� 25��
		String SQL_all = "SELECT COUNT(*) FROM GALLERY WHERE " + keyWord + " LIKE ? AND galleryAvailable = 1";
		String SQL_category = "SELECT COUNT(*) FROM GALLERY WHERE " + keyWord + " LIKE ? AND galleryCategory = ? AND galleryAvailable = 1";
		try {
			if(galleryCategory.equals("all")) {
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
		return -1;	// �����ͺ��̽� ���� 
	}
	
	// startPage �������� �޼���
	public int getStartPage(int pageNumber) {
		int startPage = ((pageNumber - 1) / 10) * 10 + 1 ;
		return startPage;
	}
	
	// endPage �������� �޼���
	public int getEndPage(int pageNumber, String galleryCategory, String keyWord, String searchWord) {
		int endPage = getStartPage(pageNumber) + 9;
		int totalPage = getTotalPage(galleryCategory, keyWord, searchWord);
		if(endPage > totalPage) {
			return totalPage;
		}
		return endPage;
	}
	
	// gallery �������� �޼��� + �˻���� �߰�
	public ArrayList<Gallery> getGalleryList(int pageNumber, String galleryCategory, String keyWord, String searchWord){
		PreparedStatement pstmt;
		ResultSet rs;
		ArrayList<Gallery> list = new ArrayList<Gallery>();
		
		String SQL_all = "SELECT * FROM GALLERY WHERE galleryAvailable = 1 AND " + keyWord + " LIKE ? ORDER BY galleryID DESC LIMIT ?, ?";
		String SQL_category = "SELECT * FROM GALLERY WHERE galleryAvailable = 1 AND galleryCategory = ? AND " + keyWord + " LIKE ? ORDER BY galleryID DESC LIMIT ?, ?";
		
		try {
			if(galleryCategory.equals("all")) {
				pstmt = conn.prepareStatement(SQL_all);
				pstmt.setString(1, "%"+searchWord+"%");
				pstmt.setInt(2, (pageNumber - 1)*25);
				pstmt.setInt(3, 25);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Gallery gallery = new Gallery();
					gallery.setGalleryID(rs.getInt(1));
					gallery.setUserNickname(rs.getString(2));
					gallery.setGalleryCategory(rs.getString(3));
					gallery.setGalleryTitle(rs.getString(4));
					gallery.setGalleryContent(rs.getString(5));
					gallery.setGalleryDate(rs.getString(6));
					gallery.setFileName(rs.getString(7));
					gallery.setFileRealName(rs.getString(8));
					gallery.setGalleryLikeCount(rs.getInt(9));
					gallery.setGalleryAvailable(rs.getInt(10));
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
					gallery.setUserNickname(rs.getString(2));
					gallery.setGalleryCategory(rs.getString(3));
					gallery.setGalleryTitle(rs.getString(4));
					gallery.setGalleryContent(rs.getString(5));
					gallery.setGalleryDate(rs.getString(6));
					gallery.setFileName(rs.getString(7));
					gallery.setFileRealName(rs.getString(8));
					gallery.setGalleryLikeCount(rs.getInt(9));
					gallery.setGalleryAvailable(rs.getInt(10));
					list.add(gallery);
			}
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}