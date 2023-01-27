import java.io.FileInputStream;
import java.io.*;
import java.sql.*;
import java.util.Properties;

import oracle.jdbc.pool.OracleDataSource;

public class DormsApp {
	Connection conn;

	public static void main(String[] args) {
		DormsApp app = new DormsApp();

		try {
			app.setConnection();
			app.showTable("dorms");
			app.showTable("staff");
			app.showStudentsByRooms();
			app.closeConnection();
		} 
		catch (SQLException eSQL) {
			System.out.println("Blad przetwarzania SQL " + eSQL.getMessage());
		}
		catch (IOException eIO) {
			System.out.println("Nie mozna otworzyc pliku" );
		}
	}

	public void setConnection() throws SQLException, IOException {
		
		Properties prop = new Properties();
		FileInputStream in = new FileInputStream("connection.properties");
		prop.load(in);
		in.close();

		String host = prop.getProperty("jdbc.host");
		String username = prop.getProperty("jdbc.username");
		String password = prop.getProperty("jdbc.password");
		String port = prop.getProperty("jdbc.port");
		String serviceName = prop.getProperty("jdbc.service.name");

		String connectionString = String.format(
									"jdbc:oracle:thin:%s/%s@//%s:%s/%s",
									username, password, host, port, serviceName);

		OracleDataSource ods;
		ods = new OracleDataSource();
		ods.setURL(connectionString);
		conn = ods.getConnection();
		System.out.println("Polaczenie do bazy danych nawiązane.");
	}

	public void closeConnection() throws SQLException {
		conn.close();
		System.out.println("Polaczenie z baza zamkniete poprawnie. \n");
	}

	public int getColumnCount(String tableName) throws SQLException{
		Statement stat_num = conn.createStatement();
		tableName = tableName.toUpperCase();
		ResultSet rs_num = stat_num.executeQuery("select count(*) from user_tab_columns where table_name=\'" + tableName + "\' ");
		int num_columns = 0;
		while (rs_num.next()){
			num_columns = Integer.parseInt(rs_num.getString(1));
		}
		return num_columns;
	}
	public void showTable(String tableName) throws SQLException {
		int num_columns = getColumnCount(tableName);
		System.out.println("Lista " + tableName + ": ");
		Statement stat = conn.createStatement();
		ResultSet rs = stat.executeQuery("SELECT * FROM " + tableName);

		System.out.println("---------------------------------");
		while (rs.next()) {
			String info = "";
			for (int i = 1; i <= num_columns; i++) {
				info += rs.getString(i) + " ";
			}
			System.out.println(info);
		}
		System.out.println("--------------------------------- \n");
		rs.close();
		stat.close();
	}


	public void showStudentsByRooms() throws SQLException {
		System.out.println("Lista studentów: ");
		Statement stat = conn.createStatement();
		ResultSet rs = stat.executeQuery("SELECT S.name, S.surname, R.room_id, D.dorm_id FROM STUDENTS S " +
						"JOIN ROOMS R on S.ROOM_ID = R.ROOM_ID JOIN DORMS D ON R.DORM_ID = D.DORM_ID order by D.dorm_id");

		System.out.println("---------------------------------");

		while (rs.next()) {
			String info = "";
			for (int i = 1; i <= 4; i++) {
				info += rs.getString(i) + " ";
			}
			System.out.println(info);
		}
		System.out.println("---------------------------------");

		rs.close();
		stat.close();
	}
}
