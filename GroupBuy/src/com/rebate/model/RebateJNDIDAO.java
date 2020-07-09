package com.rebate.model;

import java.util.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class RebateJNDIDAO implements RebateDAO_interface {

	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB1");
		} catch (NamingException e) {
			e.printStackTrace(System.err);
		}
	}
	
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setDouble(1, rebateVO.getDiscount());
			pstmt.setInt(2, rebateVO.getPeople());
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
	public void update(RebateVO rebateVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setDouble(1, rebateVO.getDiscount());
			pstmt.setInt(2, rebateVO.getPeople());
			pstmt.setString(3, rebateVO.getReb_no());
			
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
	public void delete(String reb_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, reb_no);
			
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
	public RebateVO findByPrimaryKey(String reb_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RebateVO rebateVO = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, reb_no);
			rs = pstmt.executeQuery();
			rebateVO = new RebateVO();
			
			while (rs.next()) {
				rebateVO.setReb_no(rs.getString("reb_no"));
				rebateVO.setDiscount(rs.getDouble("discount"));
				rebateVO.setPeople(rs.getInt("people"));		
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
			con = ds.getConnection();
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
			
		} catch (SQLException se) {
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
		return list;
	}

}
