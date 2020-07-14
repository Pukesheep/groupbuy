package com.gro_order.model;

import java.util.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class Gro_orderDAO implements Gro_orderDAO_interface {
	
	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB1");
		} catch (NamingException e) {
			e.printStackTrace(System.err);
		}
	}
	
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, ord_id);
			
			pstmt.executeUpdate();
			
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.out.println("rollback by Gro_orderDAO");
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
		return generatedKey;
	}

	
}
