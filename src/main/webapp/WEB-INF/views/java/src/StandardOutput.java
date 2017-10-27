public class StandardOutput {
	public static void main(String[] args) {
		System.out.println();		// 단순히 줄을 바꾼다(개행)
		
		System.out.println(true);	// 불린값을 출력하고 개행
		
		System.out.println('A');	// char 'A'를 출력하고 개행
		
		char[] x = {'A','B','C'};
		System.out.println(x);		// char 형 배열을 출력하고 개행
		
		System.out.println(99.9);	// double 형 자료를 출력하고 개행
		
		System.out.println(99.9F);	// float 형 자료를 출력하고 개행
		
		System.out.println(100);	// int 형 자료를 출력하고 개행
		
		System.out.println(40000000L); // long 형 자료를 출력하고 개행
		
		System.out.println(System.out);	// 해당 객체를 출력하고 개행

		System.out.println("표준출력메소드 테스트"); // 문자열을 출력하고 개행
	}
}