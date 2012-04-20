
public class PointRectCircleTest {

	public static void main(String[] args) {
//		Point p1 = new Point(3, 8);
//		Point p2 = new Point(6, 4);
//		Point p0 = new Point(9, 12);
//		
//		System.out.println("p0 = " + p0);
//		p0.translate(-6, -4);
//		System.out.println("p0 = " + p0);
//		
//		System.out.println("Equals: " + p1.equals(p2));
//		System.out.println("Equals: " + p1.equals(p0));
//		
//		System.out.println("Distance: " + p1.distance(p2));
//		System.out.println("Distance: " + Point.distance(p1, p2));
		
		Point p1 = new Point(3, 8);
	      Point p2 = new Point(6, 4);
	      System.out.println("p2 = " + p2);
	      System.out.println("p2 farther right? " + 
	                         (p2.getY() > p1.getY()));
	      System.out.println("Distance: " + p1.distance(p2));
	      
	      Point p3 = new Point(-2,2);
	      Point p4 = new Point(5, 5);
	      
	      Rectangle r1 = new Rectangle(p1, p2);
	      Rectangle r2 = new Rectangle(p3, p4);
	      Rectangle r3 = r1.intersection(r2);
	      System.out.println("Intersection: " + r3);
	      System.out.println("Center: " + r3.getCenter());
	      System.out.println("Inside? " + r1.isInisde(p4));
	      p4.translate(-2, -2);
	      r1.translate(3, 3);
	      System.out.println("p4 after translation: " + p4);
	      System.out.println("r1 after translation: " + r1);
	      System.out.println("Inside? " + r1.isInisde(p4));
	      System.out.println("Intersection after translation: " 
	                         + r1.intersection(r2));
	      
	      Circle c1 = new Circle(p1, 3), c2 = new Circle(p2, 2);
	      Circle c3 = new Circle(p4, 1);
	      Circle c5 = new Circle(p1, 3);
	      System.out.println(c2);
	      System.out.println("inside circle? " + c1.isInside(p1));
	      System.out.println("inside circle? " + c1.isInside(p4));
	      System.out.println("circles intersect? " + c1.intersects(c2) + 
	                         "  " +  c1.intersects(c3));
	      System.out.println("circles intersect rects? " + c1.intersects(r2) + 
	            "  " +  c3.intersects(r1));
	      System.out.println("C1 = C2: " + c1.equals(c5));
	      Rectangle s = new Square(p1, 10);
	      
	      System.out.println(s + " " + s.getArea());
	}

}
