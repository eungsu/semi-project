package kr.co.hta.shop.util;

import java.text.DecimalFormat;

public class NumberUtils {

	private static final DecimalFormat CURRENCY_FORMAT = new DecimalFormat("##,###");
	private static final DecimalFormat ONE_DECIMAL_POINT_FORMAT = new DecimalFormat("##,##0.0");
	
	/**
	 * 실수를 소숫점 두 번째 자리에서 반올림한 값으로 반환한다.
	 * @param value 실수
	 * @return 소숫점 한 자리까지만 포함하는 문자열
	 */
	public static String numberToOneDecimalPoint(double value) {
		return ONE_DECIMAL_POINT_FORMAT.format(value);
	}
	
	/**
	 * 숫자를 ,가 포함된 문자열로 반환한다.
	 * @param value 정수
	 * @return 세 자리마다 ,가 포함된 문자열
	 */
	public static String numberToCurrency(int value) {
		return CURRENCY_FORMAT.format(value);
	}
	
	/**
	 * 숫자를 3자리마다 ,로 자릿수가 표시된 문자열로 반환한다.
	 * @param value 정수
	 * @return ,를 포함하는 문자열
	 */
	public static String numberWithComma(long value) {
		return CURRENCY_FORMAT.format(value);
	}
	
	/**
	 * 숫자를 ,가 포함된 문자열로 반환한다.
	 * @param value 정수
	 * @return 세 자리마다 ,가 포함된 문자열
	 */
	public static String numberToCurrency(long value) {
		return CURRENCY_FORMAT.format(value);
	}
	
}
