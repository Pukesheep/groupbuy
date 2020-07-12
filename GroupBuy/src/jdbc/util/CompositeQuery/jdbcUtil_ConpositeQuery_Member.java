package jdbc.util.CompositeQuery;

import java.util.*;
// 萬用複合查詢
public class jdbcUtil_ConpositeQuery_Member {

	public static String get_aCondition_For_Oracle(String columnName, String value) {
		
		String aCondition = null;
		
		if ("mem_autho".equals(columnName)) {
			aCondition = columnName + " = " + value;
		} else if ("mem_id".equals(columnName) || "mem_name".equals(columnName) || "mem_email".equals(columnName)) {
			aCondition = columnName + " like '%" + value + "%'";
		}
		
		return aCondition + " ";
	}
	
	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0 && !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());
				
				if (count == 1) {
					whereCondition.append(" where " + aCondition);
				} else {
					whereCondition.append(" and " + aCondition);
				}
			}
		}
		
		return whereCondition.toString();
	}
	
	public static void main(String[] args) {
		
		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("mem_id", new String[] { "M000009" });
		map.put("mem_name", new String[] { "早餐店大冰奶" });
		map.put("mem_email", new String[] { "pg18Guardian@gmail.com" });
		map.put("mem_autho", new String[] { "99" });
		
		String finalSQL = "SELECT * FROM member"
						+ jdbcUtil_ConpositeQuery_Member.get_WhereCondition(map)
						+ "ORDER BY mem_id";
		
		System.out.println("finalSQL = " + finalSQL);
		
	}
	
	
	
}
