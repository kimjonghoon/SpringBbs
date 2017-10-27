import java.util.*;

public class ListExample {
  public static void main(String args[]) {
    List<String> list = new ArrayList<String>();
    list.add("Bernadine");
    list.add("Elizabeth");
    list.add("Gene");
    list.add("Elizabeth");
    list.add("Clara");
    System.out.println(list);
    System.out.println("2: " + list.get(2));
    System.out.println("0: " + list.get(0));
    LinkedList<String> queue = new LinkedList<String>();
    queue.addFirst("Bernadine");
    queue.addFirst("Elizabeth");
    queue.addFirst("Gene");
    queue.addFirst("Elizabeth");
    queue.addFirst("Clara");
    System.out.println(queue);
    queue.removeLast();
    queue.removeLast();
    System.out.println(queue);
  }
}
