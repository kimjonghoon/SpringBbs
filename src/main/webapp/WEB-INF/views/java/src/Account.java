// 클래스명 Account 는 대문자로 시작
public class Account {
  
  // 변수명 accountNo 는 첫문자는 소문자 두번째 어절은 대문자로 시작
  private String accountNo; 
  
  // 변수 balance 는 소문자로 시작
  private int balance;

  // setBalance는 소문자로 시작 두번째 어절 Balance 는 대문자로 시작
  public void setBalance(int amount) { 
    balance = balance + amount;
  }
  
  // getBalance 는 소문자로 시작 두번째 어절 Balance는 대문자로 시작
  public int getBalance() { 
    return balance;
  }
}
