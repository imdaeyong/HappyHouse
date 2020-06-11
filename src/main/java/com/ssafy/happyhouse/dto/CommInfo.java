package com.ssafy.happyhouse.dto;

public class CommInfo {
	/** 상가 식별 번호 */
	private int no;
	/** 상가명 */
	private String ShopName;
	/** 지점명 */
	private String LocalName;
	/** 대분류 */
	private String code1;
	/** 대분류명 */
	private String codeName1;
	/** 중분류 */
	private String code2;
	/** 중분류명 */
	private String codeName2;
	/** 소분류 */
	private String code3;
	/** 소분류명 */
	private String codeName3;
	/** 상세분류 */
	private String code4;
	/** 상세분류명 */
	private String codeName4;
	/** 법정 동코드 */
	private int dongcode;
	/** 법정동 */
	private String dong;
	/** 지번 */
	private String jibun;
	/** 도로명 */
	private String doro;
	/** 위도 경도 */
	private String lat;
	private String lng;
	
	
	public CommInfo(int no, String shopName, String localName, String code1, String codeName1, String code2,
			String codeName2, String code3, String codeName3, String code4, String codeName4, int dongcode, String dong,
			String jibun, String doro, String lat, String lng) {
		super();
		this.no = no;
		ShopName = shopName;
		LocalName = localName;
		this.code1 = code1;
		this.codeName1 = codeName1;
		this.code2 = code2;
		this.codeName2 = codeName2;
		this.code3 = code3;
		this.codeName3 = codeName3;
		this.code4 = code4;
		this.codeName4 = codeName4;
		this.dongcode = dongcode;
		this.dong = dong;
		this.jibun = jibun;
		this.doro = doro;
		this.lat = lat;
		this.lng = lng;
	}
	@Override
	public String toString() {
		return "CommInfo [no=" + no + ", ShopName=" + ShopName + ", LocalName=" + LocalName + ", code1=" + code1
				+ ", codeName1=" + codeName1 + ", code2=" + code2 + ", codeName2=" + codeName2 + ", code3=" + code3
				+ ", codeName3=" + codeName3 + ", code4=" + code4 + ", codeName4=" + codeName4 + ", dongcode="
				+ dongcode + ", dong=" + dong + ", jibun=" + jibun + ", doro=" + doro + ", lat=" + lat + ", lng=" + lng
				+ "]";
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getShopName() {
		return ShopName;
	}
	public void setShopName(String shopName) {
		ShopName = shopName;
	}
	public String getLocalName() {
		return LocalName;
	}
	public void setLocalName(String localName) {
		LocalName = localName;
	}
	public String getCode1() {
		return code1;
	}
	public void setCode1(String code1) {
		this.code1 = code1;
	}
	public String getCodeName1() {
		return codeName1;
	}
	public void setCodeName1(String codeName1) {
		this.codeName1 = codeName1;
	}
	public String getCode2() {
		return code2;
	}
	public void setCode2(String code2) {
		this.code2 = code2;
	}
	public String getCodeName2() {
		return codeName2;
	}
	public void setCodeName2(String codeName2) {
		this.codeName2 = codeName2;
	}
	public String getCode3() {
		return code3;
	}
	public void setCode3(String code3) {
		this.code3 = code3;
	}
	public String getCodeName3() {
		return codeName3;
	}
	public void setCodeName3(String codeName3) {
		this.codeName3 = codeName3;
	}
	public String getCode4() {
		return code4;
	}
	public void setCode4(String code4) {
		this.code4 = code4;
	}
	public String getCodeName4() {
		return codeName4;
	}
	public void setCodeName4(String codeName4) {
		this.codeName4 = codeName4;
	}
	public int getDongcode() {
		return dongcode;
	}
	public void setDongcode(int dongcode) {
		this.dongcode = dongcode;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}
	public String getDoro() {
		return doro;
	}
	public void setDoro(String doro) {
		this.doro = doro;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}

	
}
