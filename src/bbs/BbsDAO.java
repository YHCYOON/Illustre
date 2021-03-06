package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	Connection conn;
	
	// MySQL 접속
	public BbsDAO() {
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
	
	// 글 번호 반환 메서드 (현재 게시글 개수 +1 반환)
	public int getBbsID() {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC LIMIT 1";
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
	
	// 글쓰기 메서드
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
		return -1;	//데이터베이스 오류
	}
	
	// 총 페이지 개수를 가져오는 메서드
	public int getTotalPage(){
		PreparedStatement pstmt;
		ResultSet rs;
		int countList = 10;	// 한 페이지에 나타내는 게시글 수가 10개
		String SQL = "SELECT COUNT(IF(bbsAvailable = 1, bbsAvailable, null)) FROM BBS";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int totalPage = rs.getInt(1) / countList;
				if(rs.getInt(1) % countList > 0) {
					return totalPage + 1;
				}else {
					return totalPage;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	// 페이지 시작 범위 보여주는 메서드
	public int getStartPage(int pageNumber) {
		int startPage = ((pageNumber - 1) / 10) * 10 + 1;
		return startPage;
	}
	// 페이지 끝 범위 보여주는 메서드
	public int getEndPage(int pageNumber) {
		int endPage = getStartPage(pageNumber) + 9;
		if(endPage > getTotalPage()) {
			return getTotalPage();
		}
		return endPage;
	}
	
	
	// 페이지 게시글 리스트 보여주기 메서드
	public ArrayList<Bbs> getBbsList(int pageNumber){
		PreparedStatement pstmt;
		ResultSet rs;
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ? , ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);		
			pstmt.setInt(2, 10);		// 한 페이지당 게시글 수 countList = 10
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
	
	// 게시글 view 메서드
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
	
	// 게시글 delete 메서드
	public int deleteBbs(int bbsID) {
		PreparedStatement pstmt;
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();		// 성공시 1 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
	
	// 게시글 수정 메서드
	public int updateBbs(int bbsID, String bbsTitle, String bbsContent) {
		PreparedStatement pstmt;
		String SQL = "UPDATE BBS SET bbsTitle = ? , bbsContent = ? WHERE bbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();		// 성공시 1 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
	
	
}
