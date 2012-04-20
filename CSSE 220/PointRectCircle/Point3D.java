public class Point3D extends Point {

	private double z;
	
	public Point3D(double x, double y, double z){
		super(x, y);
		this.z = z;
		
	}
	
	public double getZ(){
		return this.z;
	}
	
	public double distance(Point3D other) {
		double dist2D = super.distance(other);
		double zDist = this.z - other.z;
		return Math.sqrt(dist2D*dist2D + zDist*zDist);
	}
	
	@Override
	public String toString() {
		String string2d =  super.toString(); 
		return string2d.replace(":", "3D:").replace("]", String.format(" %.2f]", this.z));
	}
	
	public void main(String args){
		
	}

}