// You must  not change this file.

public interface Iterator<T extends Comparable<T>> {
   boolean hasNext();
   T next();
   void remove();
}
