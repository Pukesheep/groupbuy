package com.groupbuy.model;

import java.util.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class GroupbuyDAO implements GroupbuyDAO_interface {

	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB1");
		} catch (NamingException e) {
			e.printStackTrace(System.err);
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO groupbuy (gro_id, p_id, start_date, end_date, grotime, reb1_no, reb2_no, reb3_no, status, people, money, amount) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT gro_id, p_id, start_date, end_date, grotime, reb1_no, reb2_no, reb3_no, status, people, money, amount FROM groupbuy ORDER BY gro_id";
	private static final String GET_ONE_STMT = "SELECT gro_id, p_id, start_date, end_date, grotime, reb1_no, reb2_no, reb3_no, status, people, money, amount FROM groupbuy WHERE gro_id = ?";
	private static final String DELETE = "DELETE FROM groupbuy WHERE gro_id = ?";
	private static final String UPDATE = "UPDATE groupbuy SET p_id = ?, start_date = ?, end_date = ?, grotime = ?, reb1_no = ?, reb2_no = ?, reb3_no = ?, status = ?, people = ?, money = ?, amount = ? WHERE gro_id = ?";
	private static final String JOINORQUIT = "UPDATE groupbuy SET people = ? WHERE gro_id = ?";

	@Override
	public String insert(GroupbuyVO groupbuyVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String generatedKey = "";
		
		try {
			con = ds.getConnection();
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
			pstmt.setInt(11, groupbuyVO.getAmount());
			
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
				} catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch(Exception e) {
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
			con = ds.getConnection();
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
			pstmt.setInt(11, groupbuyVO.getAmount());
			pstmt.setString(12, groupbuyVO.getGro_id());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (con != null) {
				try {
					con.close();
				} catch(Exception e) {
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, gro_id);
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
	public GroupbuyVO findByPrimaryKey(String gro_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GroupbuyVO groupbuyVO = null;
		
		try {
			con = ds.getConnection();
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
				groupbuyVO.setAmount(rs.getInt("amount"));
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
			con = ds.getConnection();
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
				groupbuyVO.setAmount(rs.getInt("amount"));
				list.add(groupbuyVO);				
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
	public void joinOrQuit(Connection con, String gro_id, Integer people) {
		
		PreparedStatement pstmt = null;
		
		try {
			
			pstmt = con.prepareStatement(JOINORQUIT);
			pstmt.setInt(1, people);
			pstmt.setString(2, gro_id);
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			
			if (con != null) {
				try {
					System.err.println("rolled back by GroupbuyDAO");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			
		} finally {
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
		
		
	}

	
}
