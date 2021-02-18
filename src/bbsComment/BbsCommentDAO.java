package bbsComment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsCommentDAO {

Connection conn;
	
	// MySQL 접속
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
	
	// 커뮤니티 댓글 등록 메서드
	public int writeBbsComment(int bbsID, String userID, String bbsComment) {
		PreparedStatement pstmt;
		String SQL = "INSERT INTO BBSCOMMENT VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, userID);
			pstmt.setString(3, bbsComment);
			pstmt.setString(4, getDate());
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();		// 성공시 1 반환
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
		
	// 커뮤니티 댓글 내용 가져오는 메서드
	public ArrayList<BbsComment> getBbsComment(int bbsID){
		PreparedStatement pstmt;
		ResultSet rs;
		ArrayList<BbsComment> list = new ArrayList<BbsComment>();
		String SQL = "SELECT * FROM BBSCOMMENT WHERE bbsID = ? , BBSAVAILABLE = 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BbsComment bbsComment = new BbsComment();
				bbsComment.setBbsID(rs.getInt(1));
				bbsComment.setUserID(rs.getString(2));
				bbsComment.setBbsComment(rs.getString(3));
				bbsComment.setBbsCommentDate(rs.getString(4));
				bbsComment.setBbsAvailable(rs.getInt(5));
				list.add(bbsComment);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 커뮤니티 댓글 개수 가져오는 메서드
	public int countBbsComment(int bbsID) {
		PreparedStatement pstmt;
		ResultSet rs;
		String SQL = "SELECT COUNT(IF(bbsAvailable = 1, bbsAvailable, null)) FROM BBSCOMMENT";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);		// 성공시 댓글 개수 반환
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	
}
