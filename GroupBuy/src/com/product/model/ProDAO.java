package com.product.model;

import java.util.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;


public class ProDAO implements ProDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "EA101G1";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO PRODUCT(P_ID,PT_ID, P_NAME, P_PRICE, P_IMAGE,P_INFO, P_SALES, P_STOCK, P_STAT) VALUES ('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'), ?, ?, ?, ?, ?, 0, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT P_ID,PT_ID,P_NAME,P_PRICE,P_IMAGE,P_INFO,P_SALES,P_STOCK,to_char(P_ADD_DATE,'yyyy-mm-dd') P_ADD_DATE,P_STAT FROM PRODUCT ORDER BY P_ID";
	private static final String GET_ONE_STMT = "SELECT P_ID,PT_ID,P_NAME,P_PRICE,P_IMAGE,P_INFO,P_SALES,P_STOCK,to_char(P_ADD_DATE,'yyyy-mm-dd') P_ADD_DATE,P_STAT FROM PRODUCT WHERE P_ID = ?";
	private static final String GET_ALL_BYPTID = "SELECT P_ID,PT_ID,P_NAME,P_PRICE,P_IMAGE,P_INFO,P_SALES,P_STOCK,to_char(P_ADD_DATE,'yyyy-mm-dd') P_ADD_DATE,P_STAT FROM PRODUCT WHERE PT_ID = ? ORDER BY P_ID";
	private static final String DELETE = "DELETE FROM PRODUCT WHERE P_ID = ?";
	private static final String UPDATE = "UPDATE PRODUCT SET  PT_ID=?, P_NAME=?, P_PRICE=?, P_IMAGE=?, P_INFO=?, P_SALES=?, P_STOCK=?, P_STAT=? WHERE P_ID=?";
	

	@Override
	public void insert(ProVO proVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, proVO.getPt_id());
			pstmt.setString(2, proVO.getP_name());
			pstmt.setDouble(3, proVO.getP_price());
			pstmt.setBytes(4, proVO.getP_image());
			pstmt.setString(5, proVO.getP_info());
			pstmt.setInt(6, proVO.getP_stock());
			pstmt.setInt(7, proVO.getP_stat());

			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public void update(ProVO proVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, proVO.getPt_id());
			pstmt.setString(2, proVO.getP_name());
			pstmt.setDouble(3, proVO.getP_price());
			pstmt.setBytes(4, proVO.getP_image());
			pstmt.setString(5, proVO.getP_info());
			pstmt.setInt(6, proVO.getP_sales());
			pstmt.setInt(7, proVO.getP_stock());
			pstmt.setInt(8, proVO.getP_stat());
			pstmt.setString(9, proVO.getP_id());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public void delete(String p_id) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, p_id);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public ProVO findByPrimaryKey(String p_id) {
		ProVO proVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, p_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				proVO = new ProVO();
				proVO.setP_id(rs.getString("p_id"));
				proVO.setPt_id(rs.getString("pt_id"));
				proVO.setP_name(rs.getString("p_name"));
				proVO.setP_price(rs.getDouble("p_price"));
				proVO.setP_image(rs.getBytes("p_image"));
				proVO.setP_info(rs.getString("p_info"));
				proVO.setP_sales(rs.getInt("p_sales"));
				proVO.setP_stock(rs.getInt("p_stock"));
				proVO.setP_add_date(rs.getDate("p_add_date"));
				proVO.setP_stat(rs.getInt("p_stat"));
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return proVO;
	}
	
	@Override
	public List<ProVO> findByPtId(String pt_id) {
		
		List<ProVO> list = new ArrayList<ProVO>();
		ProVO proVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BYPTID);

			pstmt.setString(1, pt_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				proVO = new ProVO();
				proVO.setP_id(rs.getString("p_id"));
				proVO.setPt_id(rs.getString("pt_id"));
				proVO.setP_name(rs.getString("p_name"));
				proVO.setP_price(rs.getDouble("p_price"));
				proVO.setP_image(rs.getBytes("p_image"));
				proVO.setP_info(rs.getString("p_info"));
				proVO.setP_sales(rs.getInt("p_sales"));
				proVO.setP_stock(rs.getInt("p_stock"));
				proVO.setP_add_date(rs.getDate("p_add_date"));
				proVO.setP_stat(rs.getInt("p_stat"));
				
				list.add(proVO);
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
	

	@Override
	public List<ProVO> getAll() {
		List<ProVO> list = new ArrayList<ProVO>();
		ProVO proVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				proVO = new ProVO();
				proVO.setP_id(rs.getString("p_id"));
				proVO.setPt_id(rs.getString("pt_id"));
				proVO.setP_name(rs.getString("p_name"));
				proVO.setP_price(rs.getDouble("p_price"));
				proVO.setP_image(rs.getBytes("p_image"));
				proVO.setP_info(rs.getString("p_info"));
				proVO.setP_sales(rs.getInt("p_sales"));
				proVO.setP_stock(rs.getInt("p_stock"));
				proVO.setP_add_date(rs.getDate("p_add_date"));
				proVO.setP_stat(rs.getInt("p_stat"));
				list.add(proVO);
			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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

//	@Override
//	public List<ProVO> getAllFront() {
//		List<ProVO> list = new ArrayList<ProVO>();
//		ProVO proVO = null;
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(GET_ALL_STMT);
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				
//				proVO = new ProVO();
//				if (rs.getInt("p_stat")!=0){
//				proVO.setP_id(rs.getString("p_id"));
//				proVO.setPt_id(rs.getString("pt_id"));
//				proVO.setP_name(rs.getString("p_name"));
//				proVO.setP_price(rs.getDouble("p_price"));
//				proVO.setP_image(rs.getBytes("p_image"));
//				proVO.setP_info(rs.getString("p_info"));
//				proVO.setP_sales(rs.getInt("p_sales"));
//				proVO.setP_stock(rs.getInt("p_stock"));
//				proVO.setP_add_date(rs.getDate("p_add_date"));
//				proVO.setP_stat(rs.getInt("p_stat"));
//				list.add(proVO);
//				}
//			}
//
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return list;
//	}
	
	
	
}
