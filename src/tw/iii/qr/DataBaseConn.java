package tw.iii.qr;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseConn {

	
	
	public Connection getConn() throws SQLException, Exception, IllegalAccessException, ClassNotFoundException {
	//String urlstr = "jdbc:sqlserver://qrdata.database.windows.net:1433;database=qrdata;user=qruser;password=P@ssword;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
	  //String urlstr = "jdbc:sqlserver://"+tw.iii.qr.order.daliy.ip+":1433;database=qrdata;user=sa;password=as;loginTimeout=30;";
		Connection conn;
		String urlstr = "jdbc:sqlserver://localhost:1433;database=qrdata;user=sa;password=as;loginTimeout=30;";
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conn = DriverManager.getConnection(urlstr);
		return conn;
	}
	
}
