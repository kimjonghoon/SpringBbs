import java.util.*;

public class VectorExample {
  public Vector<String> vect;

  public VectorExample () {
    vect = new Vector<String>();
  }

  public static void main ( String[] args ) {
    VectorExample ve = new VectorExample();
    for ( int i = 0; i < 10; i++ ) {
      ve.vect.addElement( String.valueOf( Math.random() * 100 ) );
    }
    for ( int i = 0; i < 10; i++ ) {
      System.out.println( ve.vect.elementAt(i) );
    }
  }
}
