import java.util.ArrayList;

/*
 * This code by Eric Stokes, David Pick and Pete Brousalis
 * May 5th 2010
 * 
 * Specification by Eric Stokes, David Pick and Pete Brousalis.
 */
/**
 * This class models a hotel that contains many lifts.
 */
public class Hotel {
	public static final int UP = 1;

	public static final int STOP = 0;

	public static final int DOWN = -1;
	
	public static final int numberOfFloors = 20;
	
	private /*@ spec_public @*/ Lift[] lifts; 
	
	private /*@ spec_public @*/ boolean[] floorsRequested;
	
	//@ public invariant (\forall int i; i >= 0 && i < lifts.length; lifts[i] != null);
	//@ public invariant (\forall int i; i >= 0 && i < lifts.length; lifts[i].getFloor() > 0 && lifts[i].getFloor() < numberOfFloors + 1);
	//@ public invariant lifts.length > 0;
	//@ public invariant floorsRequested.length >= 0;
	
	
	//@ requires numberOfLifts > 0;
	//@ ensures this.lifts.length == numberOfLifts;
	//@ ensures this.floorsRequested.length == numberOfFloors;
	//@ ensures (\forall int i; i >= 0 && i < numberOfLifts; lifts[i] != null);
	public Hotel(int numberOfLifts)
	{
		floorsRequested = new boolean[numberOfFloors];
		lifts = new Lift[numberOfLifts];
		for(int i = 0; i < numberOfLifts; i++)
		{
			lifts[i] = new Lift(numberOfFloors);
		}
	}
	
	//@ requires floorsRequested != null;
	//@ requires floor >= 0;
	//@ requires floor < floorsRequested.length;
	//@ assignable floorsRequested[floor - 1];
	//@ ensures floorsRequested[floor] == true;
	// CONSIDER: method names in Java should start with lower case (typ.)
	public void AddRequest(int floor, int direction)
	{
		floorsRequested[floor - 1] = true;
		lifts[this.FindLeastBusyLift()].buttonPressed(floor);
	}
	
	//@ requires floorsRequested != null;
	//@ requires floor >= 0;
	//@ requires floor < floorsRequested.length;
	//@ ensures floorsRequested[floor] == false;
	public void RemoveRequest(int floor)
	{
		floorsRequested[floor - 1] = false;
	}
	
	//@ requires floorsRequested != null;
	// CONSIDER: These can be mutually contradictory, since lift[0].buttonPressed 
	//           doesn't update this.floorsRequested.  Your CheckForInElevatorPresses
	//           does that update, but there is publically observable state where
	//           this spec is inconsistent.
	//@ ensures (\forall int i; i >= 0 && i < lifts.length; lifts[i].myTotalRequests() > 0 ==> \result == true);
	//@ ensures (\forall int i; i >= 0 && i < lifts.length; !floorsRequested[i] ==> \result == false);
	//@ ensures (\forall int i; i >= 0 && i < lifts.length; !floorsRequested[i] ==> \result == false);
	public /*@ pure @*/ boolean AreFloorsRequested()
	{
		for(int i = 0; i <lifts.length; i++)
		{
			if(lifts[i].myTotalRequests() > 0)
			{
				return true;
			}
		}
		return false;
	}
	

	
	//@ requires true;
	// really only used for the testing class
	public void AdvanceTime()
	{
		CheckForInElevatorPresses();
		MoveElevators();
	}
	
	//@ requires true;
	//@ assignable this.floorsRequested;
	//@ ensures (\forall int i; i >= 0 && i < lifts.length; (\forall int j; j >= 0 && j < lifts[i].getRequestedFloors().length; lifts[i].getRequestedFloors()[j] ==> this.floorsRequested[j] == true));
	private void CheckForInElevatorPresses() {
		for(int i = 0; i < lifts.length; i++)
		{
			for(int j = 0; j < lifts[i].getRequestedFloors().length; j++)
			{
				if(lifts[i].getRequestedFloors()[j])
				{
					this.floorsRequested[j] = true;
				}
			}
		}
		
	}
	
	//@ requires true;
	//@ ensures \result >= 0;
	//@ ensures \result < lifts.length;
	public int FindLeastBusyLift()
	{
		int busiestlift = this.floorsRequested.length+1;
		int leastbusylift = -1;
		for(int i = 0; i < lifts.length; i++)
		{
			if(lifts[i].myTotalRequests() < busiestlift)
			{
				leastbusylift = i;
				busiestlift = lifts[i].myTotalRequests();
			}
		}
		return leastbusylift;
	}
	
	//@ requires this.floorsRequested != null;
	//@ requires this.lifts != null;
	public void MoveElevators()
	{
		for(int i = 0; i <lifts.length; i++)
		{
			lifts[i].move();
		}
	}
	
	// Only used for display, which is why this is not speced out.
	public void ShowStatus()
	{
		System.out.println("  _  _  _  _  _ ");
		for(int i = floorsRequested.length; i > 0; i--)
		{
			if(i < 10)
			{
				System.out.print("0" + i);
			}
			else
			{
				System.out.print(i);
			}
			
			for(int j = 0; j < lifts.length; j++)
			{
				if(lifts[j].getFloor() == i)
				{
					if(lifts[j].doorsOpen())
					{
						System.out.print("|O|");
						this.floorsRequested[i - 1] = false;
					}
					else
					{
						if(lifts[j].getNextDirection() == UP)
							System.out.print("|+|");
						else if(lifts[j].getNextDirection() == DOWN)
							System.out.print("|-|");
						else
							System.out.print("|E|");
					}
				}
				else
				{
					System.out.print("| |");
				}
			}
			if(floorsRequested[i - 1])
			{
				System.out.print(" R");
			}
			System.out.println();
		}
		System.out.println();
		//for(int j = 0; j < lifts.length; j++)
		//{
		//	System.out.println("Elevator: " + j + " - Floor " + lifts[j].getFloor());
		//}
		
	}

	public void ShowLiftBusiness() 
	{
		for(int i = 0; i < lifts.length; i++)
		{
			System.out.println("Lift " + i + " has: " + lifts[i].myTotalRequests() + " requests");
		}
	}
}
