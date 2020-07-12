package com.gromem.model;

import java.util.*;
import java.sql.*;
import com.groupbuy.model.*;

public class GromemJDBCDAO implements GromemDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
	private static final String INSERT_STMT = "INSERT INTO gro_mem (mem_id, gro_id) VALUES (?, ?)";
	private static final String DELETE = "DELETE FROM gro_mem WHERE mem_id = ? and gro_id = ?";
	private static final String GET_ALL_BY_M = "SELECT * FROM gro_mem WHERE mem_id = ? ORDER BY gro_id";
	private static final String GET_ALL_BY_G = "SELECT * FROM gro_mem WHERE gro_id = ? ORDER BY mem_id";
	private static final String GET_ALL_STMT = "SELECT * FROM gro_mem ORDER BY gro_id";
	private static final String GET_ONE_STMT = "SELECT * FROM gro_mem WHERE mem_id = ? and gro_id = ?";
	
	@Override
	public void insert(GromemVO gromemVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, gromemVO.getMem_id());
			pstmt.setString(2, gromemVO.getGro_id());
			
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
	public void delete(String mem_id, String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_id);
			pstmt.setString(2, gro_id);
			
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
	public List<GromemVO> findByMem_id(String mem_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GromemVO> list = null;
		GromemVO gromemVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BY_M);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			list = new ArrayList<GromemVO>();
			
			while (rs.next()) {
				gromemVO = new GromemVO();
				gromemVO.setMem_id(rs.getString("mem_id"));
				gromemVO.setGro_id(rs.getString("gro_id"));
				list.add(gromemVO);
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
	
	@Override
	public List<GromemVO> findByGro_id(String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GromemVO> list = null;
		GromemVO gromemVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BY_G);
			pstmt.setString(1, gro_id);
			rs = pstmt.executeQuery();
			list = new ArrayList<GromemVO>();
			
			while (rs.next()) {
				gromemVO = new GromemVO();
				gromemVO.setMem_id(rs.getString("mem_id"));
				gromemVO.setGro_id(rs.getString("gro_id"));
				list.add(gromemVO);
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
	
	@Override
	public List<GromemVO> getAll() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GromemVO> list = null;
		GromemVO gromemVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			list = new ArrayList<GromemVO>();
			
			while (rs.next()) {
				gromemVO = new GromemVO();
				gromemVO.setMem_id(rs.getString("mem_id"));
				gromemVO.setGro_id(rs.getString("gro_id"));
				list.add(gromemVO);
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
	
	@Override
	synchronized public void join(GromemVO gromemVO, Integer people) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			con.setAutoCommit(false);
			pstmt.setString(1, gromemVO.getMem_id());
			pstmt.setString(2, gromemVO.getGro_id());
			pstmt.executeUpdate();
			
			GroupbuyDAO dao = new GroupbuyDAO();
			dao.joinOrQuit(con, gromemVO.getGro_id(), people);
			
			con.commit();
			con.setAutoCommit(true);
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("rollback by GromemDAO");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			} 
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
	synchronized public void quit(GromemVO gromemVO, Integer people) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			con.setAutoCommit(false);
			pstmt.setString(1, gromemVO.getMem_id());
			pstmt.setString(2, gromemVO.getGro_id());
			pstmt.executeUpdate();
			
			GroupbuyDAO dao = new GroupbuyDAO();
			dao.joinOrQuit(con, gromemVO.getGro_id(), people);
			
			con.commit();
			con.setAutoCommit(true);
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("rollback by GromemDAO");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	

	@Override
	public GromemVO findByCompositeKey(String mem_id, String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GromemVO gromemVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, mem_id);
			pstmt.setString(2, gro_id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				gromemVO = new GromemVO();
				gromemVO.setMem_id(rs.getString("mem_id"));
				gromemVO.setGro_id(rs.getString("gro_id"));
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
		
		
		return gromemVO;
	}
	

	public static void main(String[] args) {
		
		GromemJDBCDAO dao = new GromemJDBCDAO();
		
		// 新增
//		GromemVO gromemVO1 = new GromemVO();
//		gromemVO1.setMem_id("M000006");
//		gromemVO1.setGro_id("G000002");
//		dao.insert(gromemVO1);
//		gromemVO1.setMem_id("M000003");
//		gromemVO1.setGro_id("G000004");
//		dao.insert(gromemVO1);
		
		// 刪除
//		dao.delete("M000001", "G000001");
		
		// 以會員查詢團購
//		List<GromemVO> list1 = dao.findByMem_id("M000003");
//		for (GromemVO aGromem1 : list1) {
//			System.out.println("MEM_ID = " + aGromem1.getMem_id());
//			System.out.println("GRO_ID = " + aGromem1.getGro_id());
//			System.out.println("=====================================");
//		}
		
		// 以團購查詢會員
		List<GromemVO> list2 = dao.findByGro_id("G000004");
		for (GromemVO aGromem2 : list2) {
			System.out.println("MEM_ID = " + aGromem2.getMem_id());
			System.out.println("GRO_ID = " + aGromem2.getGro_id());
			System.out.println("=====================================");
		}
		
		// 查詢所有會員-團購
//		List<GromemVO> list3 = dao.getAll();
//		for (GromemVO aGromem3 : list3) {
//			System.out.println("MEM_ID = " + aGromem3.getMem_id());
//			System.out.println("GRO_ID = " + aGromem3.getGro_id());
//			System.out.println("=====================================");			
//		}
		
		// 加入團購
		GromemVO gromemVO2 = new GromemVO();
		gromemVO2.setMem_id("M000009");
		gromemVO2.setGro_id("G000004");
		dao.join(gromemVO2, 8);
		
		
	}

	
}
