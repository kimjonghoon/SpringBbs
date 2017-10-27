package test;

public class Member {
	String name;
	String mobile;
	int height;
	int weight;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String[] names = {"채수민","문승기","이미연","안태원","우태림","조선웅","김종훈"};
		String[] mobiles = {"010-7152-7920","010-2354-0939","010-5535-4229","010-2500-6688","010-3135-2407","010-6367-2747","010-4175-1146"};
		int[] heights = {180,173,160,182,155,178,165};
		int[] weights = {75,78,58,82,45,87,76};
		int length = names.length;
		
		Member[] club = new Member[7];
		for (int i = 0; i < length; i++) {
			Member member = new Member();
			member.setName(names[i]);
			member.setMobile(mobiles[i]);
			member.setHeight(heights[i]);
			member.setWeight(weights[i]);
			club[i]  = member;
		}
		
		for (int i = 0;i < length; i++) {
			System.out.println(club[i].getName() + ":" + club[i].getMobile() + ":" + club[i].getHeight() + ":" + club[i].getWeight());
		}

	}

}
