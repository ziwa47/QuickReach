﻿package tw.iii.Bundle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

import tw.iii.qr.*;
import tw.iii.qr.stock.DTO.CProduct;

public class BundlesFactory {
	
	
	LinkedList<CProduct> lcp;
	private Statement state;
	public String[] bundles ;
	public LinkedList<String[]> bundlesList = new LinkedList<String[]>();
	
	public void setBundles(String SKU,String P_name,String qty) {
		//bundles=new String[]{brand,subBrand,SKU,P_name,qty};
		bundles=new String[]{SKU,P_name,qty};
	}
	
	public LinkedList<CProduct> getProductInfo(String brand,String subBrand,String SKU,String P_name) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception {
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();

		String sqlstr = "SELECT sku,P_name,brand,subBrand FROM product where sku not like 'B00%'";

		
		if (brand != null && !brand.equals("select")){
			sqlstr += " and brand=N'" + brand + "'";

		}
		if (subBrand != null && !subBrand.equals("select")){
			sqlstr += " and subBrand=N'" + subBrand + "'";
		}
//		if (SKU != null && !SKU.equals("select")){
//			sqlstr += " and SKU='" + SKU + "'";
//		}
//		if (P_name != null && !P_name.equals("select")){
//			sqlstr += " and P_name='" + P_name + "'";
//		}
		sqlstr += "order by SKU";
		
		ResultSet rs = state.executeQuery(sqlstr);
		lcp = new LinkedList<CProduct>();
		CProduct cp ;
		
		while (rs.next()) {
			cp=new CProduct();
			cp.setSKU(rs.getString(1));
			cp.setP_name(rs.getString(2));
			cp.setBrand(rs.getString(3));
			cp.setSubBrand(rs.getString(4));
			lcp.add(cp);			
		}
		
		rs.close();
		state.close();
		conn.close();
		return lcp;
	}
	
	public LinkedList<CProduct> getBrand() throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();

		String sqlstr = "SELECT distinct brand FROM   product where brand is not null";


		ResultSet rs = state.executeQuery(sqlstr);
		lcp = new LinkedList<CProduct>();
		CProduct cp ;
		
		while (rs.next()) {
			cp=new CProduct();
			
			cp.setBrand(rs.getString(1));
			
			lcp.add(cp);			
		}
		
		rs.close();
		state.close();	
		conn.close();
		return lcp;
	}
	
	public LinkedList<CProduct> getSubBrand(String b) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();
		String sqlstr = "";
		if (b==null || b.equals("select")){

			sqlstr = "SELECT distinct subbrand FROM product where subbrand is not null";
		}else if (!b.equals("select")){
			sqlstr = "SELECT distinct subbrand FROM product where subbrand is not null and brand = N'"+b+"'";

		}
		ResultSet rs = state.executeQuery(sqlstr);
		lcp = new LinkedList<CProduct>();
		CProduct cp ;
		
		while (rs.next()) {
			cp=new CProduct();
			
			cp.setSubBrand(rs.getString(1));
			
			lcp.add(cp);			
		}
		
		rs.close();
		state.close();
		conn.close();
		return lcp;
	}
	
	
	public LinkedList<CProduct> getTotalBundles() throws IllegalAccessException, ClassNotFoundException, SQLException, Exception {
		//查看所有複合商品
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();

		String sqlstr = "SELECT sku,P_name,comment FROM product where  sku like 'B00%' order by SKU";

		ResultSet rs = state.executeQuery(sqlstr);
		lcp = new LinkedList<CProduct>();
		CProduct cp ;
		
		while (rs.next()) {
			cp=new CProduct();
			cp.setSKU(rs.getString(1));
			cp.setP_name(rs.getString(2));
			cp.setComment(rs.getString(3));
			lcp.add(cp);			
		}
		
		rs.close();
		state.close();
		conn.close();
		return lcp;
	}
	
	public LinkedList<String[]> getBundlesInfo(){		
		return bundlesList;	
	}
	

	
	public void addItem(String[] a){
		
		for(String[] x: bundlesList){
			if(x[0].equals(a[0])){
				a[2] = Integer.toString(Integer.parseInt(x[2])+Integer.parseInt(a[2]));
				bundlesList.add(a);
				bundlesList.remove(x);
				return;
			}
		}
		
		bundlesList.add(a);
		
	}
	
	public void removeItem(String a){
		
		for(String[] x:bundlesList){
			if(x[0].equals(a)){
				bundlesList.remove(x);
			}
		}
	}
	
	public void processBundles(String s){
		if (s.equals("add")) {
			addItem(bundles);
		}else {
			removeItem(s);
		}
	}
	
	public void bundlesToProduct(String sku, String pname ,String ps) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		DataBaseConn dbc = new DataBaseConn();
		Connection conn = dbc.getConn() ;
		String sqlstr = "insert into product(SKu,productType,P_name,comment) values(?,N'組合商品',?,?)";
		PreparedStatement preparedState = conn.prepareStatement(sqlstr);
		
		preparedState.setString(1, sku);		
		preparedState.setString(2, pname);
		preparedState.setString(3, ps);
		
		preparedState.execute();
		preparedState.close();
		conn.close();
	
	}
	
	public void bundlesToDetail(String sku) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{		
		
		for(String[] x: bundlesList)
		{
			DataBaseConn dbc = new DataBaseConn();
			Connection conn = dbc.getConn() ;
			

			String sqlstr = "INSERT INTO bundles (m_SKU, p_SKU, qty) VALUES (?, ?, ?);";

			PreparedStatement preparedState = conn.prepareStatement(sqlstr);		
	
			preparedState.setString(1, sku);
			preparedState.setString(2, x[0]);
			preparedState.setInt(3, Integer.parseInt(x[2]));
			
			
			preparedState.execute();
			preparedState.close();
			
			conn.close();
		}
		
								
	}
	
	public void showBundlesDetail(String bdsku) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();

		String sqlstr = "SELECT b.p_SKU,p.P_name,b.qty FROM bundles as b inner join product as p on b.p_SKU=p.SKU  where m_SKU = '" + bdsku + "'";

	
		ResultSet rs = state.executeQuery(sqlstr);
		bundlesList = new LinkedList<String[]>();
		
		while (rs.next()) {
			String[] x = new String[3];
			x[0]=rs.getString(1);
			x[1]=rs.getString(2);
			x[2]=rs.getString(3);
			bundlesList.add(x);			
		}
		
		rs.close();
		state.close();
		conn.close();
//		return bundlesList;
	}
	
	public void bundlesDeleteFormProduct(String sku) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();
		

		String sqlstr = "DELETE FROM product WHERE SKU='"+sku+"';";

		
		state.executeUpdate(sqlstr);
		state.close();
		conn.close();
	}
	
	public void bundlesDeleteFormBundles(String sku) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();
		
		String sqlstr = "DELETE FROM bundles WHERE m_SKU='"+sku+"';";
		
		state.executeUpdate(sqlstr);
		state.close();
		conn.close();
	}
	
	public int getStock(String sku) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();

		String sqlstr = "select qty from storage where sku='"+sku+"'";

		ResultSet rs = state.executeQuery(sqlstr);
	
		while (rs.next()) {
			return rs.getInt(1);		
		}
		
		rs.close();
		state.close();	
		conn.close();
		return 0;
	}
	
	public String[] getQQ(String sku) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception {
		//查看所有複合商品
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();

		String sqlstr = "SELECT sku,P_name,comment FROM product where  sku ='"+sku+"'";

		ResultSet rs = state.executeQuery(sqlstr);
		String[] strQQ = new String[3]; 
		
		while (rs.next()) {
			
			strQQ[0]=rs.getString(1);
			strQQ[1]=rs.getString(2);
			strQQ[2]=rs.getString(3);
						
		}
		
		rs.close();
		state.close();
		conn.close();
		return strQQ;
	}
	
	public boolean SKUCheck(String sku) throws IllegalAccessException, ClassNotFoundException, SQLException, Exception{
		
		DataBaseConn dbc = new DataBaseConn();		
		Connection conn = dbc.getConn() ;
		state = conn.createStatement();

		String sqlstr = "SELECT * FROM  product where sku='"+sku+"'";
		ResultSet rs = state.executeQuery(sqlstr);
		
		while(rs.next()){
			return true;
		}
		
		return false;
	}
	
}
