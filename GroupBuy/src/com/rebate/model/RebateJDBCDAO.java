package com.rebate.model;

import java.sql.*;
import java.util.*;

public class RebateJDBCDAO implements RebateDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
	private static final String INSERT_STMT = "INSERT INTO rebate (reb_no, discount, people) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL, 6, '0'), ?, ?)";
	private static final String GET_ALL_STMT = "SELECT reb_no, discount, people FROM rebate ORDER BY reb_no";
	private static final String GET_ONE_STMT = "SELECT reb_no, discount, people FROM rebate WHERE reb_no = ?";
	private static final String DELETE = "DELETE FROM rebate WHERE reb_no = ?";
	private static final String UPDATE = "UPDATE rebate SET discount = ?, people = ? WHERE reb_no = ?";
	
	@Override
	public void insert(RebateVO rebateVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
		
			pstmt.setDouble(1, rebateVO.getDiscount());
			pstmt.setInt(2, rebateVO.getPeople());
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
	public void update(RebateVO rebateVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setDouble(1, rebateVO.getDiscount());
			pstmt.setInt(2, rebateVO.getPeople());
			pstmt.setString(3, rebateVO.getReb_no());
			
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
	public void delete(String reb_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, reb_no);
			
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
	public RebateVO findByPrimaryKey(String reb_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RebateVO rebateVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, reb_no);
			rs = pstmt.executeQuery();
			rebateVO = new RebateVO();
			
			while (rs.next()) {
				rebateVO.setReb_no(rs.getString("reb_no"));
				rebateVO.setDiscount(rs.getDouble("discount"));
				rebateVO.setPeople(rs.getInt("people"));
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
		return rebateVO;
	}

	@Override
	public List<RebateVO> getAll() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<RebateVO> list = null;
		RebateVO rebateVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			list = new ArrayList<RebateVO>();
			
			while (rs.next()) {
				rebateVO = new RebateVO();
				rebateVO.setReb_no(rs.getString("reb_no"));
				rebateVO.setDiscount(rs.getDouble("discount"));
				rebateVO.setPeople(rs.getInt("people"));
				list.add(rebateVO);
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
		
		RebateJDBCDAO dao = new RebateJDBCDAO();
		
		// 新增
//		RebateVO rebateVO1 = new RebateVO();
//		rebateVO1.setDiscount(0.35d);
//		rebateVO1.setPeople(100);
//		dao.insert(rebateVO1);
//		
//		rebateVO1.setDiscount(0.26d);
//		rebateVO1.setPeople(122);
//		dao.insert(rebateVO1);
//		
//		rebateVO1.setDiscount(0.21d);
//		rebateVO1.setPeople(139);
//		dao.insert(rebateVO1);
		
		// 修改
//		RebateVO rebateVO2 = new RebateVO();
//		rebateVO2.setDiscount(0.18d);
//		rebateVO2.setPeople(150);
//		rebateVO2.setReb_no("R000007");
//		dao.update(rebateVO2);
		
		// 刪除
//		dao.delete("R000010");
		
		// 查詢單筆
		RebateVO rebateVO3 = dao.findByPrimaryKey("R000009");
		System.out.println("REB_NO = " + rebateVO3.getReb_no());
		System.out.println("DISCOUNT = " + rebateVO3.getDiscount());
		System.out.println("PEOPLE = " + rebateVO3.getPeople());
		System.out.println("=======================================");
		
		// 查詢全部
		List<RebateVO> list = dao.getAll();
		for (RebateVO aReb : list) {
			System.out.println("REB_NO = " + aReb.getReb_no());
			System.out.println("DISCOUNT = " + aReb.getDiscount());
			System.out.println("PEOPLE = " + aReb.getPeople());
			System.out.println("=======================================");			
		}
	}
	
	
}
