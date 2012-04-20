
public class ElevatorTester {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Hotel h = new Hotel(5);
		h.AddRequest(5, -1);
		h.AdvanceTime();
		h.ShowStatus();
		h.AdvanceTime();
		h.ShowStatus();
		
		h.AdvanceTime();
		h.ShowStatus();
		//for(int i = 0; i < 10; )
		h.AddRequest(2, -1);
		h.AddRequest(10, -1);
		h.AddRequest(13, -1);
		h.AddRequest(19, -1);
		h.AddRequest(12, -1);
		h.AddRequest(18, -1);
		while(h.AreFloorsRequested())
		{
			h.AdvanceTime();
			h.ShowStatus();
		}
		h.AdvanceTime();
		h.ShowStatus();

	}

}
