package com.groupbuy.model;

import java.util.*;
import java.sql.*;

public class GroupbuyJDBCDAO implements GroupbuyDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
	private static final String INSERT_STMT = "INSERT INTO groupbuy (gro_id, p_id, start_date, end_date, grotime, reb1_no, reb2_no, reb3_no, status, people, money) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT gro_id, p_id, start_date, end_date, grotime, reb1_no, reb2_no, reb3_no, status, people, money FROM groupbuy ORDER BY gro_id";
	private static final String GET_ONE_STMT = "SELECT gro_id, p_id, start_date, end_date, grotime, reb1_no, reb2_no, reb3_no, status, people, money FROM groupbuy WHERE gro_id = ?";
	private static final String DELETE = "DELETE FROM groupbuy WHERE gro_id = ?";
	private static final String UPDATE = "UPDATE groupbuy SET p_id = ?, start_date = ?, end_date = ?, grotime = ?, reb1_no = ?, reb2_no = ?, reb3_no = ?, status = ?, people = ?, money = ? WHERE gro_id = ?";
	
	@Override
	public String insert(GroupbuyVO groupbuyVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String generatedKey = "";
		
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String[] cols = {"gro_id"};
			pstmt = con.prepareStatement(INSERT_STMT, cols);
			
			pstmt.setString(1, groupbuyVO.getP_id());
			pstmt.setTimestamp(2, groupbuyVO.getStart_date());
			pstmt.setTimestamp(3, groupbuyVO.getEnd_date());
			pstmt.setInt(4, groupbuyVO.getGrotime());
			pstmt.setString(5, groupbuyVO.getReb1_no());
			pstmt.setString(6, groupbuyVO.getReb2_no());
			pstmt.setString(7, groupbuyVO.getReb3_no());
			pstmt.setInt(8, groupbuyVO.getStatus());
			pstmt.setInt(9, groupbuyVO.getPeople());
			pstmt.setDouble(10, groupbuyVO.getMoney());
			
			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			rs.next();
			generatedKey = rs.getString(1);
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return generatedKey;
	}
	
	@Override
	public void update(GroupbuyVO groupbuyVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, groupbuyVO.getP_id());;
			pstmt.setTimestamp(2, groupbuyVO.getStart_date());
			pstmt.setTimestamp(3, groupbuyVO.getEnd_date());
			pstmt.setInt(4, groupbuyVO.getGrotime());
			pstmt.setString(5, groupbuyVO.getReb1_no());
			pstmt.setString(6, groupbuyVO.getReb2_no());
			pstmt.setString(7, groupbuyVO.getReb3_no());
			pstmt.setInt(8, groupbuyVO.getStatus());
			pstmt.setInt(9, groupbuyVO.getPeople());
			pstmt.setDouble(10, groupbuyVO.getMoney());
			pstmt.setString(11, groupbuyVO.getGro_id());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public void delete(String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, gro_id);
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public GroupbuyVO findByPrimaryKey(String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GroupbuyVO groupbuyVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, gro_id);
			rs = pstmt.executeQuery();
			groupbuyVO = new GroupbuyVO();
			
			while (rs.next()) {
				groupbuyVO.setGro_id(rs.getString("gro_id"));
				groupbuyVO.setP_id(rs.getString("p_id"));
				groupbuyVO.setStart_date(rs.getTimestamp("start_date"));
				groupbuyVO.setEnd_date(rs.getTimestamp("end_date"));
				groupbuyVO.setGrotime(rs.getInt("grotime"));
				groupbuyVO.setReb1_no(rs.getString("reb1_no"));
				groupbuyVO.setReb2_no(rs.getString("reb2_no"));
				groupbuyVO.setReb3_no(rs.getString("reb3_no"));
				groupbuyVO.setStatus(rs.getInt("status"));
				groupbuyVO.setPeople(rs.getInt("people"));
				groupbuyVO.setMoney(rs.getDouble("money"));
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return groupbuyVO;
	}
	
	@Override
	public List<GroupbuyVO> getAll() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GroupbuyVO> list = null;
		GroupbuyVO groupbuyVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			list = new ArrayList<GroupbuyVO>();
			
			while (rs.next()) {
				groupbuyVO = new GroupbuyVO();
				groupbuyVO.setGro_id(rs.getString("gro_id"));
				groupbuyVO.setP_id(rs.getString("p_id"));
				groupbuyVO.setStart_date(rs.getTimestamp("start_date"));
				groupbuyVO.setEnd_date(rs.getTimestamp("end_date"));
				groupbuyVO.setGrotime(rs.getInt("grotime"));
				groupbuyVO.setReb1_no(rs.getString("reb1_no"));
				groupbuyVO.setReb2_no(rs.getString("reb2_no"));
				groupbuyVO.setReb3_no(rs.getString("reb3_no"));
				groupbuyVO.setStatus(rs.getInt("status"));
				groupbuyVO.setPeople(rs.getInt("people"));
				groupbuyVO.setMoney(rs.getDouble("money"));				
				list.add(groupbuyVO);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	public static void main(String[] args) {
		
		GroupbuyJDBCDAO dao = new GroupbuyJDBCDAO();
		
		// 新增
//		Timestamp now = new Timestamp(System.currentTimeMillis());
//		int days = 7;
//		Timestamp grotime = new Timestamp(days * 24 * 60 * 60 * 1000L);
//		Timestamp end = new Timestamp(now.getTime() + grotime.getTime());
		
		GroupbuyVO groupbuyVO1 = new GroupbuyVO();
		groupbuyVO1.setP_id("P007");
		Timestamp now = new Timestamp(System.currentTimeMillis());
		int days = 7;
		Timestamp grotime = new Timestamp(days * 24 * 60 * 60 * 1000L);
		Timestamp end = new Timestamp(now.getTime() + grotime.getTime());
		groupbuyVO1.setStart_date(now);
		groupbuyVO1.setGrotime(7);
		groupbuyVO1.setEnd_date(end);
		groupbuyVO1.setReb1_no("R000001");
		groupbuyVO1.setReb2_no("R000002");
		groupbuyVO1.setReb3_no("R000003");
		groupbuyVO1.setStatus(0);
		groupbuyVO1.setPeople(5);
		groupbuyVO1.setMoney(588.584949d);
		String gro_id = dao.insert(groupbuyVO1);
		System.out.println(gro_id);
		
		// 修改
//		GroupbuyVO groupbuyVO2 = new GroupbuyVO();
//		Timestamp now = new Timestamp(System.currentTimeMillis());
//		int days = 1;
//		Timestamp grotime = new Timestamp(days * 24 * 60 * 60 * 1000L);
//		Timestamp end = new Timestamp(now.getTime() + grotime.getTime());
//		groupbuyVO2.setP_id("P004");
//		groupbuyVO2.setStart_date(now);
//		groupbuyVO2.setGrotime_date(days);
//		groupbuyVO2.setEnd_date(end);
//		groupbuyVO2.setReb1_no("R000003");
//		groupbuyVO2.setReb2_no("R000004");
//		groupbuyVO2.setReb3_no("R000005");
//		groupbuyVO2.setStatus(2);
//		groupbuyVO2.setPeople(1);
//		groupbuyVO2.setMoney(10.5d);
//		groupbuyVO2.setGro_id("G000003");
//		dao.update(groupbuyVO2);
		
		// 刪除
//		dao.delete("G000005");
		
		// 查詢單筆
//		GroupbuyVO groupbuyVO3 = dao.findByPrimaryKey("G000003");
//		System.out.println("GRO_ID = " + groupbuyVO3.getGro_id());
//		System.out.println("P_ID = " + groupbuyVO3.getP_id());
//		System.out.println("START_DATE = " + groupbuyVO3.getStart_date());
//		System.out.println("GROTIME_DATE = " + groupbuyVO3.getGrotime_date());
//		System.out.println("END_DATE = " + groupbuyVO3.getEnd_date());
//		System.out.println("REB1_NO = " + groupbuyVO3.getReb1_no());
//		System.out.println("REB2_NO = " + groupbuyVO3.getReb2_no());
//		System.out.println("REB3_NO = " + groupbuyVO3.getReb3_no());
//		System.out.println("STATUS = " + groupbuyVO3.getStatus());
//		System.out.println("PEOPLE = " + groupbuyVO3.getPeople());
//		System.out.println("MONEY = " + groupbuyVO3.getMoney());
//		System.out.println("============================");
		
		// 查詢全部
		List<GroupbuyVO> list = dao.getAll();
		for (GroupbuyVO aGroupbuy : list) {
			System.out.println("GRO_ID = " + aGroupbuy.getGro_id());
			System.out.println("P_ID = " + aGroupbuy.getP_id());
			System.out.println("START_DATE = " + aGroupbuy.getStart_date());
			System.out.println("GROTIME_DATE = " + aGroupbuy.getGrotime());
			System.out.println("END_DATE = " + aGroupbuy.getEnd_date());
			System.out.println("REB1_NO = " + aGroupbuy.getReb1_no());
			System.out.println("REB2_NO = " + aGroupbuy.getReb2_no());
			System.out.println("REB3_NO = " + aGroupbuy.getReb3_no());
			System.out.println("STATUS = " + aGroupbuy.getStatus());
			System.out.println("PEOPLE = " + aGroupbuy.getPeople());
			System.out.println("MONEY = " + aGroupbuy.getMoney());
			System.out.println("============================");
		}
		
	}
	
}
