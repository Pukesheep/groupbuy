package com.gromem.model;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import com.groupbuy.model.*;

public class GromemDAO implements GromemDAO_interface {
	
	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB1");
		} catch (NamingException e) {
			e.printStackTrace(System.err);
		}
	}

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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, gromemVO.getMem_id());
			pstmt.setString(2, gromemVO.getGro_id());
			
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
	public void delete(String mem_id, String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_id);
			pstmt.setString(2, gro_id);
			
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
	public List<GromemVO> findByMem_id(String mem_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GromemVO> list = null;
		GromemVO gromemVO = null;
		
		try {
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			list = new ArrayList<GromemVO>();
			
			while (rs.next()) {
				gromemVO = new GromemVO();
				gromemVO.setMem_id(rs.getString("mem_id"));
				gromemVO.setGro_id(rs.getString("gro_id"));
				list.add(gromemVO);
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
	synchronized public void join(GromemVO gromemVO, Integer people) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			con.setAutoCommit(false);
			pstmt.setString(1, gromemVO.getMem_id());
			pstmt.setString(2, gromemVO.getGro_id());
			pstmt.executeUpdate();
			
			GroupbuyDAO dao = new GroupbuyDAO();
			dao.joinOrQuit(con, gromemVO.getGro_id(), people);
			
			con.commit();
			con.setAutoCommit(true);
			
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			con.setAutoCommit(false);
			pstmt.setString(1, gromemVO.getMem_id());
			pstmt.setString(2, gromemVO.getGro_id());
			pstmt.executeUpdate();
			
			GroupbuyDAO dao = new GroupbuyDAO();
			dao.joinOrQuit(con, gromemVO.getGro_id(), people);
			
			con.commit();
			con.setAutoCommit(true);
			
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
	public GromemVO findByCompositeKey(String mem_id, String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GromemVO gromemVO = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, mem_id);
			pstmt.setString(2, gro_id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				gromemVO = new GromemVO();
				gromemVO.setMem_id(rs.getString("mem_id"));
				gromemVO.setGro_id(rs.getString("gro_id"));
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
		return gromemVO;
	}

}
