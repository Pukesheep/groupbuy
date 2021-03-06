package com.gro_order.model;

import java.util.*;
import java.sql.*;

public class Gro_orderJDBCDAO implements Gro_orderDAO_interface {
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
	private static final String INSERT_STMT = "INSERT INTO gro_order (ord_id, gro_id, mem_id, ordstat_id, ord_price, receive_name, address, phone) VALUES ('GO'||LPAD(GRO_ORDER_seq.NEXTVAL,6,'0'), ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT ="SELECT * FROM gro_order ORDER BY ord_id";
	private static final String DELETE = "DELETE FROM gro_order WHERE ord_id = ?";
	private static final String GET_ONE_STMT = "SELECT * FROM gro_order WHERE ord_id = ?";
	private static final String GET_ALL_BY_M = "SELECT * FROM gro_order WHERE mem_id = ?";
	private static final String GET_ALL_BY_G = "SELECT * FROM gro_order WHERE gro_id = ?";
	private static final String UPDATE = "UPDATE gro_order SET gro_id = ?, mem_id = ?, ordstat_id = ?, ord_price = ?, ord_date = ?, receive_name = ?, address = ?, phone = ? WHERE ord_id = ?";
	private static final String ORDING = "INSERT INTO gro_order (ord_id, gro_id, mem_id, ordstat_id, ord_price) VALUES ('GO'||LPAD(GRO_ORDER_seq.NEXTVAL,6,'0'), ?, ?, ?, ?)";
	

	@Override
	public String insert(Gro_orderVO gro_orderVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String generatedKey = "";
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String[] cols = {"ord_id"};
			pstmt = con.prepareStatement(INSERT_STMT, cols);
					
			pstmt.setString(1, gro_orderVO.getGro_id());
			pstmt.setString(2, gro_orderVO.getMem_id());
			pstmt.setString(3, gro_orderVO.getOrdstat_id());
			pstmt.setDouble(4, gro_orderVO.getOrd_price());
			pstmt.setString(5, gro_orderVO.getReceive_name());
			pstmt.setString(6, gro_orderVO.getAddress());
			pstmt.setString(7, gro_orderVO.getPhone());
			
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
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return generatedKey;
	}

	@Override
	public void update(Gro_orderVO gro_orderVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, gro_orderVO.getGro_id());
			pstmt.setString(2, gro_orderVO.getMem_id());
			pstmt.setString(3, gro_orderVO.getOrdstat_id());
			pstmt.setDouble(4, gro_orderVO.getOrd_price());
			pstmt.setTimestamp(5, gro_orderVO.getOrd_date());
			pstmt.setString(6, gro_orderVO.getReceive_name());
			pstmt.setString(7, gro_orderVO.getAddress());
			pstmt.setString(8, gro_orderVO.getPhone());
			pstmt.setString(9, gro_orderVO.getOrd_id());
			
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
	public void delete(String ord_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, ord_id);
			
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
	public Gro_orderVO findByPrimaryKey(String ord_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Gro_orderVO gro_orderVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, ord_id);
			rs = pstmt.executeQuery();
			gro_orderVO = new Gro_orderVO();
			
			while (rs.next()) {
				gro_orderVO.setOrd_id(rs.getString("ord_id"));
				gro_orderVO.setGro_id(rs.getString("gro_id"));
				gro_orderVO.setMem_id(rs.getString("mem_id"));
				gro_orderVO.setOrd_price(rs.getDouble("ord_price"));
				gro_orderVO.setOrdstat_id(rs.getString("ordstat_id"));
				gro_orderVO.setOrd_date(rs.getTimestamp("ord_date"));
				gro_orderVO.setReceive_name(rs.getString("receive_name"));
				gro_orderVO.setAddress(rs.getString("address"));
				gro_orderVO.setPhone(rs.getString("phone"));
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
		return gro_orderVO;
	}

	@Override
	public List<Gro_orderVO> getAll() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Gro_orderVO> list = null;
		Gro_orderVO gro_orderVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			list = new ArrayList<Gro_orderVO>();
			
			while (rs.next()) {
				gro_orderVO = new Gro_orderVO();
				gro_orderVO.setOrd_id(rs.getString("ord_id"));
				gro_orderVO.setGro_id(rs.getString("gro_id"));
				gro_orderVO.setMem_id(rs.getString("mem_id"));
				gro_orderVO.setOrd_price(rs.getDouble("ord_price"));
				gro_orderVO.setOrdstat_id(rs.getString("ordstat_id"));
				gro_orderVO.setOrd_date(rs.getTimestamp("ord_date"));
				gro_orderVO.setReceive_name(rs.getString("receive_name"));
				gro_orderVO.setAddress(rs.getString("address"));
				gro_orderVO.setPhone(rs.getString("phone"));
				list.add(gro_orderVO);
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
	public List<Gro_orderVO> findByMem_id(String mem_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Gro_orderVO> list = null;
		Gro_orderVO gro_orderVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BY_M);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			list = new ArrayList<Gro_orderVO>();
			
			while (rs.next()) {
				gro_orderVO = new Gro_orderVO();
				gro_orderVO.setOrd_id(rs.getString("ord_id"));
				gro_orderVO.setGro_id(rs.getString("gro_id"));
				gro_orderVO.setMem_id(rs.getString("mem_id"));
				gro_orderVO.setOrd_price(rs.getDouble("ord_price"));
				gro_orderVO.setOrdstat_id(rs.getString("ordstat_id"));
				gro_orderVO.setOrd_date(rs.getTimestamp("ord_date"));
				gro_orderVO.setReceive_name(rs.getString("receive_name"));
				gro_orderVO.setAddress(rs.getString("address"));
				gro_orderVO.setPhone(rs.getString("phone"));
				list.add(gro_orderVO);
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
	public List<Gro_orderVO> findByGro_id(String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Gro_orderVO> list = null;
		Gro_orderVO gro_orderVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BY_G);
			pstmt.setString(1, gro_id);
			rs = pstmt.executeQuery();
			list = new ArrayList<Gro_orderVO>();
			
			while (rs.next()) {
				gro_orderVO = new Gro_orderVO();
				gro_orderVO.setOrd_id(rs.getString("ord_id"));
				gro_orderVO.setGro_id(rs.getString("gro_id"));
				gro_orderVO.setMem_id(rs.getString("mem_id"));
				gro_orderVO.setOrd_price(rs.getDouble("ord_price"));
				gro_orderVO.setOrdstat_id(rs.getString("ordstat_id"));
				gro_orderVO.setOrd_date(rs.getTimestamp("ord_date"));
				gro_orderVO.setReceive_name(rs.getString("receive_name"));
				gro_orderVO.setAddress(rs.getString("address"));
				gro_orderVO.setPhone(rs.getString("phone"));
				list.add(gro_orderVO);
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
	synchronized public String ording(Gro_orderVO gro_orderVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String generatedKey = "";
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String[] cols = {"ord_id"};
			pstmt = con.prepareStatement(ORDING, cols);
			con.setAutoCommit(false);
			
			pstmt.setString(1, gro_orderVO.getGro_id());
			pstmt.setString(2, gro_orderVO.getMem_id());
			pstmt.setString(3, gro_orderVO.getOrdstat_id());
			pstmt.setDouble(4, gro_orderVO.getOrd_price());
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			rs.next();
			generatedKey = rs.getString(1);
			
			con.commit();
			con.setAutoCommit(true);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("rollback by Gro_orderDAO");
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
		return generatedKey;
	}
	
	public static void main(String[] args) {
		
		Gro_orderJDBCDAO dao = new Gro_orderJDBCDAO();
		
		// 新增
//		Gro_orderVO gro_orderVO1 = new Gro_orderVO();
//		gro_orderVO1.setGro_id("G000003");
//		gro_orderVO1.setMem_id("M000006");
//		gro_orderVO1.setOrd_price(500);
//		gro_orderVO1.setOrdstat_id("003");
//		gro_orderVO1.setReceive_name("okokfine");
//		gro_orderVO1.setAddress("五樓");
//		gro_orderVO1.setPhone("0912345678");
//		String generatedKey = dao.insert(gro_orderVO1);
//		System.out.println("自增主鍵值 = " + generatedKey);
		
		// 修改
//		Gro_orderVO gro_orderVO2 = new Gro_orderVO();
//		gro_orderVO2.setOrd_id("GO000004");
//		gro_orderVO2.setGro_id("G000002");
//		gro_orderVO2.setMem_id("M000012");
//		gro_orderVO2.setOrd_price(100);
//		gro_orderVO2.setOrdstat_id("006");
//		gro_orderVO2.setReceive_name("kdkdk");
//		gro_orderVO2.setAddress("六樓");
//		gro_orderVO2.setPhone("0987654321");
//		Timestamp now = new Timestamp(System.currentTimeMillis());
//		gro_orderVO2.setOrd_date(now);
//		dao.update(gro_orderVO2);
		
		// 查單筆
//		Gro_orderVO gro_orderVO3 = dao.findByPrimaryKey("GO000001");
//		System.out.println("ORD_ID = " + gro_orderVO3.getOrd_id());
//		System.out.println("GRO_ID = " + gro_orderVO3.getGro_id());
//		System.out.println("MEM_ID = " + gro_orderVO3.getMem_id());
//		System.out.println("ORD_PRICE = " + gro_orderVO3.getOrd_price());
//		System.out.println("ORDSTAT_ID = " + gro_orderVO3.getOrdstat_id());
//		System.out.println("ORD_DATE = " + gro_orderVO3.getOrd_date());
//		System.out.println("RECEIVE_NAME = " + gro_orderVO3.getReceive_name());
//		System.out.println("ADDRESS = " + gro_orderVO3.getAddress());
//		System.out.println("PHONE = " + gro_orderVO3.getPhone());
//		System.out.println("======================================");
		
		// 查全部
//		List<Gro_orderVO> list1 = dao.getAll();
//		for (Gro_orderVO aGro_order : list1) {
//			System.out.println("ORD_ID = " + aGro_order.getOrd_id());
//			System.out.println("GRO_ID = " + aGro_order.getGro_id());
//			System.out.println("MEM_ID = " + aGro_order.getMem_id());
//			System.out.println("ORD_PRICE = " + aGro_order.getOrd_price());
//			System.out.println("ORDSTAT_ID = " + aGro_order.getOrdstat_id());
//			System.out.println("ORD_DATE = " + aGro_order.getOrd_date());
//			System.out.println("RECEIVE_NAME = " + aGro_order.getReceive_name());
//			System.out.println("ADDRESS = " + aGro_order.getAddress());
//			System.out.println("PHONE = " + aGro_order.getPhone());
//			System.out.println("======================================");
//		}
		
		// 以會員查訂單
//		List<Gro_orderVO> list2 = dao.findByMem_id("M000001");
//		for (Gro_orderVO aGro_order : list2) {
//			System.out.println("ORD_ID = " + aGro_order.getOrd_id());
//			System.out.println("GRO_ID = " + aGro_order.getGro_id());
//			System.out.println("MEM_ID = " + aGro_order.getMem_id());
//			System.out.println("ORD_PRICE = " + aGro_order.getOrd_price());
//			System.out.println("ORDSTAT_ID = " + aGro_order.getOrdstat_id());
//			System.out.println("ORD_DATE = " + aGro_order.getOrd_date());
//			System.out.println("RECEIVE_NAME = " + aGro_order.getReceive_name());
//			System.out.println("ADDRESS = " + aGro_order.getAddress());
//			System.out.println("PHONE = " + aGro_order.getPhone());
//			System.out.println("======================================");
//		}
		
		// 以團購查訂單
//		List<Gro_orderVO> list3 = dao.findByGro_id("G000001");
//		for (Gro_orderVO aGro_order : list3) {
//			System.out.println("ORD_ID = " + aGro_order.getOrd_id());
//			System.out.println("GRO_ID = " + aGro_order.getGro_id());
//			System.out.println("MEM_ID = " + aGro_order.getMem_id());
//			System.out.println("ORD_PRICE = " + aGro_order.getOrd_price());
//			System.out.println("ORDSTAT_ID = " + aGro_order.getOrdstat_id());
//			System.out.println("ORD_DATE = " + aGro_order.getOrd_date());
//			System.out.println("RECEIVE_NAME = " + aGro_order.getReceive_name());
//			System.out.println("ADDRESS = " + aGro_order.getAddress());
//			System.out.println("PHONE = " + aGro_order.getPhone());
//			System.out.println("======================================");
//		}
		
		// 成立訂單
//		Gro_orderVO gro_orderVO4 = new Gro_orderVO();
//		gro_orderVO4.setGro_id("G000003");
//		gro_orderVO4.setMem_id("M000002");
//		gro_orderVO4.setOrdstat_id("002");
//		gro_orderVO4.setOrd_price(500.4d);
//		dao.ording(gro_orderVO4);
		
		// 成立一拖拉庫訂單
		List<Gro_orderVO> list4 = new ArrayList<Gro_orderVO>();
		Gro_orderVO gro_orderVO5 = null;
		for (int i = 1; i < 10; i++) {
			gro_orderVO5 = new Gro_orderVO();
			gro_orderVO5.setGro_id("G000003");
			gro_orderVO5.setMem_id("M00000" + i);
			gro_orderVO5.setOrdstat_id("002");
			gro_orderVO5.setOrd_price(18114.0d);
			list4.add(gro_orderVO5);
		}
		List<String> plist = new ArrayList<String>();
		for (Gro_orderVO aGro_order : list4) {
			System.out.println(aGro_order.getGro_id());
			System.out.println(aGro_order.getMem_id());
			System.out.println(aGro_order.getOrdstat_id());
			System.out.println(aGro_order.getOrd_price());
			System.out.println("=============================");
			plist.add(dao.ording(aGro_order));
		}
		for (String primaryKey : plist) {
			System.out.println(primaryKey);
		}
		
		
	}


}
