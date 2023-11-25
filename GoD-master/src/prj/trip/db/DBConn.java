package prj.trip.db;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConn {
	private Connection conn = null;
	
	
	
	public Connection getConnection() {
		Properties prop = new Properties(); 
		
		
		try {
			String path = DBConn.class.getResource("db.properties").getPath();
			Reader reader = new FileReader(path);
			
			prop.load(reader);
			
			String driver = prop.getProperty("driver");
			String dburl = prop.getProperty("url");
			String dbuid = prop.getProperty("user");
			String dbpwd = prop.getProperty("pwd");
			
			Class.forName(driver);
			conn = DriverManager.getConnection(dburl,dbuid,dbpwd);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
}
