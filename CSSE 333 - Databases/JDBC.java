package connection;
import java.sql.*;


/**
 * This test class opens a connection to the server and sends some simply queries.
 * 
 * @author Curt Clifton and Bryan Musial
 * based partly on code examples by Rene Steiner, http://www.akadia.com/services/sqlsrv_jdbc.html
 * and Carb Simien, http://www.mcse.ms/message1260690.html 
 */
public class JDBC {

	/**
	 * The connection protocol for connections to the database server.
	 */
	private static final String CONNECTION_PROTOCOL = "jdbc:sqlserver";

	/**
	 * The URL of the server.
	 */
	private static final String SERVER = "localhost";

	/**
	 * The name of the copy of the Northwind database to manipulate.
	 */
	private static final String NORTHWIND = "Northwind";

	/**
	 * The port to connect to the server on.
	 */
	private static final int PORT = 1433;

	/**
	 * Exercises the JDBC interface.
	 * 
	 * @param args
	 *            ignored
	 */
	public static void main(String[] args) {
		try {
			registerSQLServerDriver();
		} catch (SQLException e1) {
			e1.printStackTrace();
			return;
		}
		System.out.println("Driver registration successful.");

		// -------------------------------------------------------------------
		// Prompts user for username and password
//		ConnectionInfo pwd = new ConnectionInfo("SQLServer Account",
//				"Enter your SQLServer account information.");
//		if (pwd.wasCancelled()) {
//			System.out.println("Request for username and password cancelled.");
//			return;
//		}
		
		// -------------------------------------------------------------------
		// Tests connection to server
//		try {
//			testConnection(pwd);
//		} catch (SQLException e) {
//			e.printStackTrace();
//			return; // aborts execution if this stage didn't work
//		}
//		System.out.println("Connection successful.");
//		printSeparatorLine();
//		printSeparatorLine();

		// -------------------------------------------------------------------
		// Runs a simple query 
//		try {
//			testQuery(pwd);
//		} catch (SQLException e) {
//			e.printStackTrace();
//			return; // aborts execution if this stage didn'twork
//		}
//		System.out.println("Simple query did not throw an exception.");
//		printSeparatorLine();
//		printSeparatorLine();
		
		// -------------------------------------------------------------------
		// Runs a stored procedure
//		try {
//			executeStoredProcedure(pwd);
//		} catch (SQLException e) {
//			e.printStackTrace();
//			return; // aborts execution if this stage didn'twork
//		}
//		System.out
//				.println("Stored procedure did not throw an exception (on the Java side anyway).");
//		printSeparatorLine();
//		printSeparatorLine();
	}

	/**
	 * Registers the SQLServer driver.
	 * @throws SQLException 
	 */
	private static boolean registerSQLServerDriver() throws SQLException {
		// Register JDBC driver
		DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
		return true;
	}

	/**
	 * Establishes a connection to the server at the given URL using the given
	 * username and password. Requires: !pwd.wasCancelled()
	 * 
	 * @param url
	 * @param pwd
	 *            ConnectionInfo containing the username and passward
	 * @return a connection to the server
	 * @throws SQLException
	 */
	private static Connection getConnection(String url, ConnectionInfo pwd) throws SQLException {
		Connection connection = DriverManager.getConnection(url, pwd.getUsername(), new String(pwd
				.getPassword()));
		return connection;
	}

	/**
	 * Opens a connection to the server.
	 * 
	 * @param pwd
	 *            the username and password info for the connection
	 * 
	 * @throws SQLException
	 *             if connection cannot be established
	 */
	private static void testConnection(ConnectionInfo pwd) throws SQLException {
		// Set connection parameters (change servername, username, and password
		String url = CONNECTION_PROTOCOL + "://" + SERVER + ":" + PORT;
		Connection conn = getConnection(url, pwd);
		if (conn == null) {
			throw new SQLException("Null connection returned.");
		}
		conn.close();
	}

	/**
	 * Opens a connection to the database and asks for some data, which it then
	 * displays.
	 * 
	 * @param pwd
	 *            the username and password info for the connection
	 * 
	 * @throws SQLException
	 */
	private static void testQuery(ConnectionInfo pwd) throws SQLException {
		// Connects to specific database
		String url = CONNECTION_PROTOCOL + "://" + SERVER + ":" + PORT + ";DatabaseName="
				+ NORTHWIND + ";SelectMethod=cursor;";
		Connection conn = getConnection(url, pwd);

		// Performs a simple query on the database to demonstrate the technique.
		// Typically you should call a stored procedure instead, but this serves
		// to demonstrate the initial technique of sending an SQL command.
		String query = "SELECT * FROM Customers";
		PreparedStatement stmt = conn.prepareStatement(query);
		// Replaces the question mark in the query string with a parameter,
		// while avoid SQL injection attacks
		//stmt.setString(1, "Germany");

		// Execute the query
		stmt.execute();

		// Processes all the results
		processRows(stmt);

		// Cleans up
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
	}

	/**
	 * Opens a connection to the database and executes a stored procedure.
	 * Displays the results of the stored procedure, include output parameters,
	 * return code, and tables.
	 * 
	 * @param pwd
	 *            the username and password info for the connection
	 * 
	 * @throws SQLException
	 */
	private static void executeStoredProcedure(ConnectionInfo pwd) throws SQLException {
		// Connects to specific database
		String url = CONNECTION_PROTOCOL + "://" + SERVER + ":" + PORT + ";DatabaseName="
				+ NORTHWIND + ";SelectMethod=cursor;";
		Connection conn = getConnection(url, pwd);

		// Calls a stored procedure using parameters for the arguments and for
		// the result code.
		String query = "{ ? = call uspCustomersByCountry( ? , ? ) }";
		CallableStatement cstmt = conn.prepareCall(query);
		// Replaces the question marks in the query string with parameters. Only
		// the second question mark is an input parameter; the others are output
		// parameters that we can read from after executing the procedure.
		// while avoid SQL injection attacks
		cstmt.registerOutParameter(1, Types.INTEGER); // return code
		cstmt.setString(2, "Germany"); // customerID, input parameter
		cstmt.registerOutParameter(3, Types.INTEGER); // output parameter

		// Executes the stored procedure
		cstmt.execute();

		// Processes all the results
		processRows(cstmt);

		// Retrieves the return code and any output parameters.
		// It's best to do this after all result sets and update counts have
		// been retrieved.
		System.out.println("Return code: " + cstmt.getInt(1));
		System.out.println("Count from output parameter:  " + cstmt.getInt(3));

		// Cleanup
		cstmt.close();
		cstmt = null;
		conn.close();
		conn = null;
	}

	/**
	 * Outputs the most-recent results of the given statement to the console.
	 * Handles the fact that a given query can include multiple result sets.
	 * 
	 * @param stmt
	 * @throws SQLException
	 */
	private static void processRows(Statement stmt) throws SQLException {
		ResultSet rs = null;
		int rsCount = -1;
		while (true) {
			int updateCount = stmt.getUpdateCount();

			// rows were affected
			if (updateCount > 0) {
				printSeparatorLine();
				System.out.println("(" + updateCount + " row(s) affected)");
				stmt.getMoreResults();
				System.out.println();
				continue;
			}

			// DDL or zero rows affected
			if (updateCount == 0) {
				printSeparatorLine();
				System.out.println("No rows changed, or the query was a DDL statement.");
				stmt.getMoreResults();
				System.out.println();
				continue;
			}

			// rows were returned
			rs = stmt.getResultSet();
			if (rs != null) {
				rsCount++;
				System.out.println("ResultSet #" + rsCount);
				displayRows(rs);
				stmt.getMoreResults();
				System.out.println();
				continue;
			}
			break;
		}
	}

	/**
	 * Outputs the given result set to the console as a table.
	 * 
	 * @param rs
	 * @throws SQLException
	 */
	private static void displayRows(ResultSet rs) throws SQLException {
		printSeparatorLine();
		ResultSetMetaData rsmd = rs.getMetaData();
		int numOfColumns = rsmd.getColumnCount();
		int r = 0;

		for (int i = 1; i <= numOfColumns; i++) {
			System.out.print(rsmd.getColumnLabel(i));
			if (i != numOfColumns)
				System.out.print(" , ");
		}
		System.out.println("");
		while (rs.next()) {
			r++;
			System.out.print("Row: " + r + ": ");
			for (int i = 1; i <= numOfColumns; i++) {
				System.out.print(rs.getString(i));
				
				Object columnObject = rs.getObject(i);
				
				if (i != numOfColumns)
					System.out.print(" , ");
			}
			System.out.println("");
		}
	}

	private static void printSeparatorLine() {
		System.out.println("=================================================================");
	}
}
