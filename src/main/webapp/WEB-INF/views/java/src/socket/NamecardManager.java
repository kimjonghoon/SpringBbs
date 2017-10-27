package net.java_school.namecard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NamecardManager {
	public NamecardManager() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void close(ResultSet rs,
			PreparedStatement pstmt, 
			Connection con) {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	public Connection getConnection() throws SQLException {
		Connection con = null;
		con = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "scott", "tiger");
		return con;
	}
	public void addNamecard(Namecard namecard) {
		String sql ="insert into " +
				"namecard " +
				"values (seq_namecard_no.nextval," +
				"?, ?, ?, ?)";
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, namecard.getName());
			pstmt.setString(2, namecard.getCompany());
			pstmt.setString(3, namecard.getMobile());
			pstmt.setString(4, namecard.getEmail());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
	}
	public void deleteNamecard(int no) {
		String sql ="delete from namecard where no=?";
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null,pstmt,con);
		}
		
	}
	public Namecard getNamecard(int no) {
		Namecard namecard = null;
		String sql ="select * from namecard where no=?";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String name = rs.getString("name");
				String company = rs.getString("company");
				String mobile = rs.getString("mobile");
				String email = rs.getString("email");
				namecard = new Namecard(name,company,mobile,email);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs,pstmt,con);
		}
		return namecard;
	}
	public ArrayList<Namecard> findNamecard(String search) {
		String searchWord = "%" + search + "%";
		ArrayList<Namecard> matchingCard = 
			new ArrayList<Namecard>();
		String sql ="select * from namecard " +
				" where name like ? " +
				" or company like ? " +
				" or mobile like ? " +
				" or email like ?";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, searchWord);
			pstmt.setString(2, searchWord);
			pstmt.setString(3, searchWord);
			pstmt.setString(4, searchWord);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int no = rs.getInt("no");
				String sname = rs.getString("name");
				String company = rs.getString("company");
				String mobile = rs.getString("mobile");
				String email = rs.getString("email");
				Namecard namecard = new Namecard(no,sname,company,mobile,email);
				matchingCard.add(namecard);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs,pstmt,con);
		}
		return matchingCard;
	}
	public ArrayList<Namecard> getNamecards() {
		ArrayList<Namecard> namecards =
			new ArrayList<Namecard>();
		String sql ="select * from namecard";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String company = rs.getString("company");
				String mobile = rs.getString("mobile");
				String email = rs.getString("email");
				Namecard namecard = new Namecard(no,name,company,mobile,email);
				namecards.add(namecard);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs,pstmt,con);
		}
		return namecards;
	}
	public void modifyNamecard(Namecard namecard) {
		String sql = "update namecard " +
				" set name=?," +
				"company=?," +
				"mobile=?," +
				"email=? " +
				" where no=?";
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, namecard.getName());
			pstmt.setString(2, namecard.getCompany());
			pstmt.setString(3, namecard.getMobile());
			pstmt.setString(4, namecard.getEmail());
			pstmt.setInt(5, namecard.getNo());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(null,pstmt,con);
		}
		
	}
}
