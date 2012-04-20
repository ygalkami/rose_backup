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
	
	private CallButton[] callButtons;
	
	private boolean[] floorsRequested;
	private int[] floorAssignment;
	//@ requires numberOfLifts > 0;
	//@ ensures this.lifts.length == numberOfLifts;
	public Hotel(int numberOfLifts)
	{
		floorAssignment = new int[numberOfFloors];
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
	//@ ensures floorsRequested[floor] == true;
	public void AddRequest(int floor, int direction)
	{
		floorsRequested[floor - 1] = true;
		//lifts[this.FindNearestElevator(floor)].buttonPressed(floor);
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
	public boolean AreFloorsRequested()
	{
		for(int i = 0; i <floorsRequested.length; i++)
		{
			if(floorsRequested[i])
			{
				return true;
			}
		}
		return false;
	}
	
	
	public void AdvanceTime()
	{
		if(AreFloorsRequested())
		{
			MoveElevators();
		}
	}
	public int GetFloorRequests(int floor)
	{
		int floorBelow = 0;
		int floorAbove = 0;
		for(int i = floor+1; i <floorsRequested.length; i++)
		{
			if(floorsRequested[i])
			{
				floorAbove = 1;
			}
		}
		for(int i = 0; i < floor; i++)
		{
			if(floorsRequested[i])
			{
				floorBelow = 2;
			}
		}
		return floorBelow + floorAbove;
	}
	
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
	
	public int FindNearestElevator(int floor)
	{
		int distanceFromFloor = this.numberOfFloors + 1;
		int currentElevator = -1;
		
		for(int i = 0; i < lifts.length; i++)
		{
			if(floorAssignment[i] == 0 && distanceFromFloor > Math.abs(floor - lifts[i].getFloor()))
			{
				currentElevator = i;
			}
		}
		return currentElevator;
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
