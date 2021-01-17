package kr.co.hta.shop.util;

public class StringUtils {
	
	/**
	 * 문자열이 null이면 빈 문자열을 반환한다.
	 * @param value 문자열
	 * @return 문자열이 null이면 빈 문자열, null이 아니면 해당 문자를 반환한다.
	 */
	public static String nullToBlank(String value) {
		if (value == null) {
			return "";
		}
		return value;
	}
	
	/**
	 * 문자열이 비어있는지 여부를 반환한다.
	 * @param value 문자열
	 * @return 문자열이 null, 빈문자열, 공백문자인 경우 true를 반환한다.
	 */
	public static boolean isEmpty(String value) {
		if (value == null) {
			return true;
		}
		return value.trim().isEmpty();
	}
	
	/**
	 * 문자열을 지정된 길이만큼 잘라서 반환한다.
	 * @param text 문자열
	 * @param maxLength 최대 길이
	 * @return 문자열을 지정된 길이만큼 잘라서 반환한다. 
	 *         null이면 빈문자를 반환하고, 지정된 길이보다 짧거나 같으며 자르지 않고 그대로 반환한다.
	 */
	public static String getStringForLength(String text, int maxLength) {
		if (text == null) {
			return "";
		}
		if (text.length() <= maxLength) {
			return text;
		}
		return text.substring(0, maxLength) + "...";
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @param defaultValue 기본값
	 * @return 정수, 문자열이 null이거나 숫자변환시 오류가 발생하면 기본값을 반환한다.
	 */
	public static int stringToInt(String value, int defaultValue) {
		if (value == null) {
			return defaultValue;
		}
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @return 정수, 문자열이 null이거나 숫자변환시 오류가 발생하면 0을 반환한다.
	 */
	public static int stringToInt(String value) {
		return stringToInt(value, 0);
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @param defaultValue 기본값
	 * @return 정수, 문자열이 null이거나 숫자변환시 오류가 발생하면 기본값을 반환한다.
	 */
	public static long stringToLong(String value, long defaultValue) {
		if (value == null) {
			return defaultValue;
		}
		try {
			return Long.parseLong(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @return 정수, 문자열이 null이거나 숫자변환시 오류가 발생하면 0을 반환한다.
	 */
	public static long stringToLong(String value) {
		return stringToLong(value, 0L);
	}
	
	/**
	 * 문자열을 실수로 변환한다.
	 * @param value 문자열
	 * @param defaultValue 기본값
	 * @return 실수, 문자열이 null이거나 숫자변환시 오류가 발생하면 기본값을 반환한다.
	 */
	public static double stringToDouble(String value, double defaultValue) {
		if (value == null) {
			return defaultValue;
		}
		try {
			return Double.parseDouble(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	/**
	 * 문자열을 실수로 변환한다.
	 * @param value 문자열
	 * @return 실수, 문자열이 null이거나 숫자변환시 오류가 발생하면 0을 반환한다.
	 */
	public static double stringToDouble(String value) {
		return stringToDouble(value, 0.0);
	}
}
