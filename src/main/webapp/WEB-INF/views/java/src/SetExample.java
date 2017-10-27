import java.util.*;

public class SetExample {
  public static void main(String args[]) {
    Set<String> set = new HashSet<String>();
    set.add("Bernadine");
    set.add("Elizabeth");
    set.add("Gene");
    set.add("Elizabeth");
    set.add("Clara");
    System.out.println(set);
    Set<String> sortedSet = new TreeSet<String>(set);
    System.out.println(sortedSet);
  }
}
