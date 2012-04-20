import java.util.Queue;

/*
 * Code by Curt Clifton, Rose-Hulman Institute of Technology.
 * April 29, 2009.
 * 
 * Specification by Eric Stokes, David Pick and Pete Brousalis.
 */

/**
 * This class models a lift.
 */
public class Lift {
	/* You don't need to specify anything about these constants. */
	public static final int UP = 1;

	public static final int STOP = 0;

	public static final int DOWN = -1;

	
	private /*@ spec_public @*/ int location;

	private /*@ spec_public @*/ boolean[] floorRequestLight;

	private /*@ spec_public @*/ boolean upArrowLight;

	private /*@ spec_public @*/ boolean downArrowLight;

	private /*@ spec_public @*/ int nextDirection;
	
	private /*@ spec_public @*/ int[] requestQueue;

	private /*@ spec_public @*/ boolean doorsOpen;


	//@ public invariant this.floorRequestLight.length >= 0;
	//@ public invariant this.location >= 0;
	//@ public invariant this.location <= this.floorRequestLight.length;
	/*@ public invariant this.nextDirection == UP ||
	                     this.nextDirection == STOP ||
	                     this.nextDirection == DOWN;
	 */
	//@ public invariant !this.doorsOpen ==> (!this.upArrowLight && !this.downArrowLight);
	/*@ public invariant this.doorsOpen ==> (this.upArrowLight && !this.downArrowLight) ||
	                                        (!this.upArrowLight && this.downArrowLight) ||
	                                        (!this.upArrowLight && !this.downArrowLight);
	*/
	
	
	//@ requires numberOfFloors >= 0;
	//@ assignable this.location, this.floorRequestLight, this.upArrowLight, this.downArrowLight, this.nextDirection, this.doorsOpen;
	//@ ensures this.location == 0;
	//@ ensures this.upArrowLight == false;
	//@ ensures this.downArrowLight == false;
	//@ ensures this.nextDirection == STOP;
	//@ ensures this.doorsOpen == false;
	//@ ensures this.floorRequestLight.length == numberOfFloors;
	//@ ensures (\forall int k; 0 < k && k < this.floorRequestLight.length; this.floorRequestLight[k] == false);
	public Lift(int numberOfFloors) {
		this.location = 0;
		this.floorRequestLight = new boolean[numberOfFloors];
		this.upArrowLight = false;
		this.downArrowLight = false;
		this.nextDirection = STOP;
		this.doorsOpen = false;
	}
	
	//@ requires floor > 0;
	//@ requires floor <= this.floorRequestLight.length;
	//@ requires floorRequestLight != null;
	public void buttonPressed(int floor) {
		this.floorRequestLight[floor - 1] = true;
	}
	
	//@ requires this.location < this.floorRequestLight.length - 1;
	//@ assignable this.location;
	//@ ensures this.location == \old(this.location) + 1;
	public void movedUp() {
		this.location++;
	}

	//@ requires this.location > 0;
	//@ assignable this.location;
	//@ ensures this.location == \old(this.location) - 1;
	public void movedDown() {
		this.location--;
	}

	//@ requires this.floorRequestLight != null;
	//@ requires this.location < this.floorRequestLight.length;
	/*@ requires this.nextDirection == UP ||
                 this.nextDirection == STOP ||
                 this.nextDirection == DOWN;
     */
	//@ ensures this.floorRequestLight[this.location] == false;
	public void doorsOpened() {
		this.doorsOpen = true;
		findNextDirection();
		if (this.nextDirection == UP) {
			this.upArrowLight = true;
			this.downArrowLight = false;
		} else if (this.nextDirection == DOWN) {
			this.downArrowLight = true;
			this.upArrowLight = false;
		} else {
			this.downArrowLight = false;
			this.upArrowLight = false;
		}
		this.floorRequestLight[this.location] = false;
	}

	public void findNextDirection()
	{
		if(this.nextDirection == UP)
		{
			if(requestedFloorsAbove(this.getFloor()))
			{
				this.nextDirection = UP;
			}
			else if(requestedFloorsBelow(this.getFloor()))
			{
				this.nextDirection = DOWN;
			}
			else
			{
				this.nextDirection = STOP;
			}
		}
		else if(this.nextDirection == DOWN)
		{
			if(requestedFloorsBelow(this.getFloor()))
			{
				this.nextDirection = DOWN;
			}
			else if(requestedFloorsAbove(this.getFloor()))
			{
				this.nextDirection = UP;
			}
			else
			{
				this.nextDirection = STOP;
			}
		}
		else
		{
			if(requestedFloorsAbove(this.getFloor()))
			{
				this.nextDirection = UP;
			}
			else if(requestedFloorsBelow(this.getFloor()))
			{
				this.nextDirection = DOWN;
			}
			else
			{
				this.nextDirection = STOP;
			}
		}
	}
	//@ requires floorRequestLight != null;
	//@ requires floor >= 0;
	public boolean requestedFloorsAbove(int floor)
	{
		for(int i = floor; i < this.floorRequestLight.length; i++)
		{
			if(this.floorRequestLight[i])
			{
				return true;
			}
		}
		return false;
	}
	
	//@ requires floorRequestLight != null;
	//@ requires floor < floorRequestLight.length;
	public boolean requestedFloorsBelow(int floor)
	{
		for(int i = floor - 1; i >= 0; i--)
		{
			if(this.floorRequestLight[i])
			{
				return true;
			}
		}
		return false;
	}
	
	//@ requires floorRequestLight != null;
	public int myTotalRequests()
	{
		int requests = 0;
		for(int i = 0; i < this.floorRequestLight.length; i++)
		{
			if(floorRequestLight[i])
			{
				requests++;
			}
		}
		return requests;
	}
	
	//@ requires this.floorRequestLight != null;
	//@ requires this.getFloor() > 0;
	//@ requires this.getFloor() <= this.floorRequestLight.length;
	//@ requires this.location < this.floorRequestLight.length - 1;
	//@ requires this.location > 0;
	public void move()
	{
		this.findNextDirection();
		if(this.doorsOpen)
		{
			this.doorsClosed();
		}
		else if(isFloorRequestLit(this.getFloor()))
		{
			this.doorsOpened();
		}
		else if(this.nextDirection == UP)
		{
			this.movedUp();
		}
		else if(this.nextDirection == DOWN)
		{
			this.movedDown();
		}
	}
	
	//@ requires true;
	//@ assignable this.doorsOpen, this.upArrowLight, this.downArrowLight;
	public void doorsClosed() {
		this.doorsOpen = false;
		this.downArrowLight = false;
		this.upArrowLight = false;
	}
	
	//@ requires true;
	//@ assignable \nothing;
	//@ ensures \result == this.location + 1;
	public /*@ pure @*/ int getFloor() {
		return this.location + 1;
	}
	
	//@ requires this.floorRequestLight != null;
	//@ requires floor > 0;
	//@ requires floor <= this.floorRequestLight.length;
	public boolean isFloorRequestLit(int floor) {
		return this.floorRequestLight[floor - 1];
	}

	//@ ensures \result == this.downArrowLight;
	public boolean isDownArrowLit() {
		return this.downArrowLight;
	}

	//@ ensures \result == this.upArrowLight;
	public boolean isUpArrowLit() {
		return this.upArrowLight;
	}
	
	public int getNextDirection()
	{
		return this.nextDirection;
	}
	
	public boolean doorsOpen()
	{
		return this.doorsOpen;
	}

}