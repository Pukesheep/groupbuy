package com.member.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import jdbc.util.CompositeQuery.jdbcUtil_ConpositeQuery_Member;

import java.io.*;

public class MemberJDBCDAO implements MemberDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "EA101G1";
	String passwd = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO member (mem_id, mem_email, mem_pass, mem_name, mem_icon, mem_phone, mem_addr, bank_acc, card_no, card_yy, card_mm, card_sec, mem_autho, mem_bonus, mem_joindat, mem_birth, mem_warn) VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT mem_id, mem_email, mem_pass, mem_name, mem_icon, mem_phone, mem_addr, bank_acc, card_no, card_yy, card_mm, card_sec, mem_autho, mem_bonus, to_char(mem_joindat, 'yyyy-mm-dd') mem_joindat, to_char(mem_birth, 'yyyy-mm-dd') mem_birth, mem_warn FROM member ORDER BY mem_id";
	private static final String GET_ONE_STMT = "SELECT mem_id, mem_email, mem_pass, mem_name, mem_icon, mem_phone, mem_addr, bank_acc, card_no, card_yy, card_mm, card_sec, mem_autho, mem_bonus, to_char(mem_joindat, 'yyyy-mm-dd') mem_joindat, to_char(mem_birth, 'yyyy-mm-dd') mem_birth, mem_warn FROM member WHERE mem_id = ?";
	private static final String DELETE = "DELETE FROM member WHERE mem_id = ?";
	private static final String UPDATE = "UPDATE member SET mem_email = ?, mem_pass = ?, mem_name = ?, mem_icon = ?, mem_phone = ?, mem_addr = ?, bank_acc = ?, card_no = ?, card_yy = ?, card_mm = ?, card_sec = ?, mem_autho = ?, mem_bonus = ?, mem_birth = ?, mem_warn = ? WHERE mem_id = ?";
	private static final String LOGIN = "SELECT mem_id FROM member WHERE mem_email = ?";
	private static final String SIGN_UP = "INSERT INTO member (mem_id, mem_name, mem_email, mem_pass, mem_autho, mem_joindat) VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, SYSDATE)";
	
	@Override
	public String insert(MemberVO memberVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String generatedKey = "";
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String[] cols = {"mem_id"};
			pstmt = con.prepareStatement(INSERT_STMT, cols);
			
			pstmt.setString(1, memberVO.getMem_email());
			pstmt.setString(2, memberVO.getMem_pass());
			pstmt.setString(3, memberVO.getMem_name());
			pstmt.setBytes(4, memberVO.getMem_icon());
			pstmt.setString(5, memberVO.getMem_phone());
			pstmt.setString(6, memberVO.getMem_addr());
			pstmt.setString(7, memberVO.getBank_acc());
			pstmt.setNString(8, memberVO.getCard_no());
			pstmt.setString(9, memberVO.getCard_yy());
			pstmt.setString(10, memberVO.getCard_mm());
			pstmt.setString(11, memberVO.getCard_sec());
			pstmt.setInt(12, memberVO.getMem_autho());
			pstmt.setInt(13, memberVO.getMem_bonus());
			pstmt.setDate(14, memberVO.getMem_joindat());
			pstmt.setDate(15, memberVO.getMem_birth());
			pstmt.setInt(16, memberVO.getMem_warn());
			
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
	public void update(MemberVO memberVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, memberVO.getMem_email());
			pstmt.setString(2, memberVO.getMem_pass());
			pstmt.setString(3, memberVO.getMem_name());
			pstmt.setBytes(4, memberVO.getMem_icon());
			pstmt.setString(5, memberVO.getMem_phone());
			pstmt.setString(6, memberVO.getMem_addr());
			pstmt.setString(7, memberVO.getBank_acc());
			pstmt.setString(8, memberVO.getCard_no());
			pstmt.setString(9, memberVO.getCard_yy());
			pstmt.setString(10, memberVO.getCard_mm());
			pstmt.setString(11, memberVO.getCard_sec());
			pstmt.setInt(12, memberVO.getMem_autho());
			pstmt.setInt(13, memberVO.getMem_bonus());
			pstmt.setDate(14, memberVO.getMem_birth());
			pstmt.setInt(15, memberVO.getMem_warn());
			pstmt.setString(16, memberVO.getMem_id());
			
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
	public void delete(String mem_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_id);
			
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
	public MemberVO findByPrimaryKey(String mem_id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO memberVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			memberVO = new MemberVO();
			
			while (rs.next()) {
				memberVO.setMem_id(rs.getString("mem_id"));
				memberVO.setMem_email(rs.getString("mem_email"));
				memberVO.setMem_pass(rs.getString("mem_pass"));
				memberVO.setMem_icon(rs.getBytes("mem_icon"));
				memberVO.setMem_phone(rs.getString("mem_phone"));
				memberVO.setMem_addr(rs.getString("mem_addr"));
				memberVO.setBank_acc(rs.getString("bank_acc"));
				memberVO.setCard_no(rs.getString("card_no"));
				memberVO.setCard_yy(rs.getString("card_yy"));
				memberVO.setCard_mm(rs.getString("card_mm"));
				memberVO.setCard_sec(rs.getString("card_sec"));
				memberVO.setMem_autho(rs.getInt("mem_autho"));
				memberVO.setMem_bonus(rs.getInt("mem_bonus"));
				memberVO.setMem_joindat(rs.getDate("mem_joindat"));
				memberVO.setMem_birth(rs.getDate("mem_birth"));
				memberVO.setMem_warn(rs.getInt("mem_warn"));
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
		return memberVO;
	}

	@Override
	public List<MemberVO> getAll() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		java.util.List<MemberVO> list = null;
		MemberVO memberVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			list = new ArrayList<MemberVO>();
			
			while (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMem_id(rs.getString("mem_id"));
				memberVO.setMem_email(rs.getString("mem_email"));
				memberVO.setMem_pass(rs.getString("mem_pass"));
				memberVO.setMem_name(rs.getString("mem_name"));
				memberVO.setMem_icon(rs.getBytes("mem_icon"));
				memberVO.setMem_phone(rs.getString("mem_phone"));
				memberVO.setMem_addr(rs.getString("mem_addr"));
				memberVO.setBank_acc(rs.getString("bank_acc"));
				memberVO.setCard_no(rs.getString("card_no"));
				memberVO.setCard_yy(rs.getString("card_yy"));
				memberVO.setCard_mm(rs.getString("card_mm"));
				memberVO.setCard_sec(rs.getString("card_sec"));
				memberVO.setMem_autho(rs.getInt("mem_autho"));
				memberVO.setMem_bonus(rs.getInt("mem_bonus"));
				memberVO.setMem_joindat(rs.getDate("mem_joindat"));
				memberVO.setMem_birth(rs.getDate("mem_birth"));
				memberVO.setMem_warn(rs.getInt("mem_warn"));
				list.add(memberVO);
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
	public List<MemberVO> getAll(Map<String, String[]> map) {
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String finalSQL = "SELECT * FROM member"
					+ jdbcUtil_ConpositeQuery_Member.get_WhereCondition(map)
					+ " ORDER BY mem_id";
			pstmt = con.prepareStatement(finalSQL);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMem_id(rs.getString("mem_id"));
				memberVO.setMem_email(rs.getString("mem_email"));
				memberVO.setMem_pass(rs.getString("mem_pass"));
				memberVO.setMem_name(rs.getString("mem_name"));
				memberVO.setMem_icon(rs.getBytes("mem_icon"));
				memberVO.setMem_phone(rs.getString("mem_phone"));
				memberVO.setMem_addr(rs.getString("mem_addr"));
				memberVO.setBank_acc(rs.getString("bank_acc"));
				memberVO.setCard_no(rs.getString("card_no"));
				memberVO.setCard_yy(rs.getString("card_yy"));
				memberVO.setCard_mm(rs.getString("card_mm"));
				memberVO.setCard_sec(rs.getString("card_sec"));
				memberVO.setMem_autho(rs.getInt("mem_autho"));
				memberVO.setMem_bonus(rs.getInt("mem_bonus"));
				memberVO.setMem_joindat(rs.getDate("mem_joindat"));
				memberVO.setMem_birth(rs.getDate("mem_birth"));
				memberVO.setMem_warn(rs.getInt("mem_warn"));
				list.add(memberVO); // Store the row in the List
			}
			
			// Handle any SQL errors
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
	public String loginByEmail(String mem_email) {
		java.sql.Connection con = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		String mem_id = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(LOGIN);
			pstmt.setString(1, mem_email);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				mem_id = rs.getString("mem_id");
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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
		return mem_id;
	}
	

	@Override
	public String signUp(MemberVO memberVO) {
		java.sql.Connection con = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		String generatedKey = null;
		
		try {
			Class.forName(driver);
			String[] cols = {"mem_id"};
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SIGN_UP, cols);
			pstmt.setString(1, memberVO.getMem_name());
			pstmt.setString(2, memberVO.getMem_email());
			pstmt.setString(3, memberVO.getMem_pass());
			pstmt.setInt(4, memberVO.getMem_autho());
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			
			while (rs.next()) {
				generatedKey = rs.getString(1);
			}
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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

	public static void main(String[] args) {
		
		byte[] image1, image2;
//		try {
//			image1 = getPictureByteArray("WebContent/Forum/image/1.jpg");
//			image2 = getPictureByteArray("WebContent/Forum/image/2.gif");
			
			MemberJDBCDAO dao = new MemberJDBCDAO();
			
			// 新增
//			MemberVO memberVO1 = new MemberVO();
//			memberVO1.setMem_email("556648va@gmail.com");
//			memberVO1.setMem_pass("123456");
//			memberVO1.setMem_name("Goodjob");
//			memberVO1.setMem_icon(image1);
//			memberVO1.setMem_phone("0910123456");
//			memberVO1.setMem_addr("No.300, Zhongda Rd., Zhongli Dist., Taoyuan City");
//			memberVO1.setBank_acc("384758394851");
//			memberVO1.setCard_no("2748596839485774");
//			memberVO1.setCard_yy("2029");
//			memberVO1.setCard_mm("03");
//			memberVO1.setCard_sec("393");
//			memberVO1.setMem_autho(2);
//			memberVO1.setMem_bonus(50000);
//			java.util.Calendar cu = new java.util.GregorianCalendar(1998, Calendar.MARCH, 5);
//			java.sql.Date ds = new java.sql.Date(cu.getTimeInMillis());
//			memberVO1.setMem_birth(ds);
//			memberVO1.setMem_warn(0);
//			dao.insert(memberVO1);
			
//			// 修改
//			MemberVO memberVO2 = new MemberVO();
//			memberVO2.setMem_email("ioio@gmail.com");
//			memberVO2.setMem_pass("ikikdkfmm39");
//			memberVO2.setMem_name("NiceJob");
//			memberVO2.setMem_icon(image2);
//			memberVO2.setMem_phone("0999999999");
//			memberVO2.setMem_addr("No. 139, Zhonghe Rd., Zhongli Dist., Taoyuan City 320");
//			memberVO2.setBank_acc("110000000000");
//			memberVO2.setCard_no("1234567890123456");
//			memberVO2.setCard_yy("9999");
//			memberVO2.setCard_mm("99");
//			memberVO2.setCard_sec("999");
//			memberVO2.setMem_autho(0);
//			memberVO2.setMem_bonus(10);
//			java.util.Calendar cu1 = new java.util.GregorianCalendar(9999, Calendar.SEPTEMBER, 9);
//			java.sql.Date ds1 = new java.sql.Date(cu1.getTimeInMillis());
//			memberVO2.setMem_birth(ds1);
//			memberVO2.setMem_warn(99);
//			memberVO2.setMem_id("M000010");
//			dao.update(memberVO2);
			
			// 刪除
//			dao.delete("M000009");
			
			// 查詢單筆
//			MemberVO memberVO3 = dao.findByPrimaryKey("M000013");
//			System.out.println("MEM_ID = " + memberVO3.getMem_id());
//			System.out.println("MEM_EMAIL = " + memberVO3.getMem_email());
//			System.out.println("MEM_PASS = " + memberVO3.getMem_pass());
//			System.out.println(memberVO3.getMem_icon());
//			System.out.println("MEM_PHONE = " + memberVO3.getMem_phone());
//			System.out.println("MEM_ADDR = " + memberVO3.getMem_addr());
//			System.out.println("BANK_ACC = " + memberVO3.getBank_acc());
//			System.out.println("CARD_NO = " + memberVO3.getCard_no());
//			System.out.println("CARD_YY = " + memberVO3.getCard_yy());
//			System.out.println("CARD_MM = " + memberVO3.getCard_mm());
//			System.out.println("CARD_SEC = " + memberVO3.getCard_sec());
//			System.out.println("MEM_AUTHO = " + memberVO3.getMem_autho());
//			System.out.println("MEM_BONUS = " + memberVO3.getMem_bonus());
//			System.out.println("MEM_JOINDAT = " + memberVO3.getMem_joindat());
//			System.out.println("MEM_BIRTH = " + memberVO3.getMem_birth());
//			System.out.println("MEM_WARN = " + memberVO3.getMem_warn());
			
			// 查詢全部
//			java.util.List<MemberVO> list = dao.getAll();
//			for (MemberVO aMember : list) {
//				System.out.println("MEM_ID = " + aMember.getMem_id());
//				System.out.println("MEM_EMAIL = " + aMember.getMem_email());
//				System.out.println("MEM_PASS = " + aMember.getMem_pass());
////				System.out.println(aMember.getMem_icon());
//				System.out.println("MEM_PHONE = " + aMember.getMem_phone());
//				System.out.println("MEM_ADDR = " + aMember.getMem_addr());
//				System.out.println("BANK_ACC = " + aMember.getBank_acc());
//				System.out.println("CARD_NO = " + aMember.getCard_no());
//				System.out.println("CARD_YY = " + aMember.getCard_yy());
//				System.out.println("CARD_MM = " + aMember.getCard_mm());
//				System.out.println("CARD_SEC = " + aMember.getCard_sec());
//				System.out.println("MEM_AUTHO = " + aMember.getMem_autho());
//				System.out.println("MEM_BONUS = " + aMember.getMem_bonus());
//				System.out.println("MEM_JOINDAT = " + aMember.getMem_joindat());
//				System.out.println("MEM_BIRTH = " + aMember.getMem_birth());
//				System.out.println("MEM_WARN = " + aMember.getMem_warn());
//				System.out.println("=====================================");
//			}
			
			// 註冊
//			MemberVO memberVO4 = new MemberVO();
//			memberVO4.setMem_email("123ggg@gmail.com");
//			memberVO4.setMem_pass("123456");
//			memberVO4.setMem_autho(1);
//			dao.signUp(memberVO4);
			
			String memii = dao.loginByEmail("difjdifj@gmail.com");
			System.out.println(memii);;
			
//		} catch (IOException ioe) {
//			ioe.printStackTrace(System.err);
//		}
		
	}
	
	public static byte[] getPictureByteArray(String path) throws IOException {
		
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while ((i = fis.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		fis.close();
		
		return baos.toByteArray();
	}

	
}
