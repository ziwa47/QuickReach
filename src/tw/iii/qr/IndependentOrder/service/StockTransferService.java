package tw.iii.qr.IndependentOrder.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.iii.qr.IndependentOrder.model.entity.StockTransferlogMaster;
import tw.iii.qr.IndependentOrder.model.repository.AbstractDAO;
import tw.iii.qr.IndependentOrder.model.repository.StockTransferDAO;
import tw.iii.qr.IndependentOrder.tool.DateUtils;

@Service

public class StockTransferService extends AbstractService<StockTransferlogMaster> {
	@Autowired
	private StockTransferDAO stockTransferDAO;


	// 流水號種類(03:訂單)
	private static final String ORDERS_TYPE = "03";

	@Override
	protected AbstractDAO<StockTransferlogMaster> getDAO() {
		return stockTransferDAO;
	}

	/**
	 * 製作轉倉單號碼<br/>
	 * 1.取得今天日期(yyyyMMdd)<br/>
	 * 2.取得流水號種類(03:訂單)<br/>
	 * 3.取得倉別<br/>
	 * 4.取出StockTransferMaster裡今天的訂單張數並加1並補0至三位數<br/>
	 * 5.ex. (2)+(3) = (yyyyMMdd03KH001)<br/>
	 */
	@Transactional
	public String makeStockTransferMasterId(String warehouse) {

		String stockTransferMasterId = "";

		try {

			// 1.取得今天日期(yyyyMMdd)<br/>

			Date date = DateUtils.clearTime(new Date());
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			System.out.println(date);
			String today = dateFormat.format(date);
			
			// 2.取得流水號種類(03:訂單)<br/>
			String orderType = ORDERS_TYPE;
			
			// 3.取得代碼(未定)<br/>
			String ordersCode = warehouse;
			
			// 4.取出IordersMaster裡今天的訂單張數並加1並補0至三位數<br/>
			String todayCount = String.format("%03d", stockTransferDAO.selectTodayCount(date, warehouse) + 1) ;

			// 5.ex. (2)+(3) = (yyyyMMddxxx001)<br/>
			stockTransferMasterId = today + orderType + ordersCode + todayCount;
			
			System.out.println("stockTransferMasterId:"+stockTransferMasterId);

		} catch (Exception e) {
			System.out.println(e);

			e.printStackTrace();
		}
		return stockTransferMasterId;

	}
	
	
	
	/**送出獨立訂單<br/>
	 * 1.儲存客戶資料Guest<br/>
	 * 2.儲存獨立訂單主檔iorders_master<br/>
	 * 3.儲存訂單明細iorders_detail<br/>
	 * 
	 * */
	public int processIorder(HttpServletRequest request) {
		
	
		
		return 0;
	}

	
	public int iorderMaster(HttpServletRequest request) throws Exception {

		 
		return 0;
		
	}
	
	

	/**取得獨立訂單的總售價totalPrice<br/>
	 * 
	 * 1.獨立訂單頁面的最後一筆訂單商品資料的編號<br/>
	 * 2.獨立訂單所有訂單商品資料的編號<br/>
	 * 3.檢查(1)、(2)，...<br/><br/>
	 * 
	 * 相關loop不花時間想註解了，請直接詢問作者吧 by 輝哥、kidd<br/><br/>~那些在資策會看輝哥一枝獨秀的日子
	 * 
	 * */
	public BigDecimal totalPrice(HttpServletRequest request) throws Exception {
		
		int count = Integer.parseInt(request.getParameter("count"));
		LinkedList<Integer> times = new LinkedList<>();
		
		double totalPrice = 0;
		
		for (String s : request.getParameterValues("times")) {
			times.add(Integer.parseInt(s));
		}

		for (int i = 1; i <= count; i++) {
			if (times.indexOf(i) == -1)
				continue;


			int qty = Integer.valueOf(request.getParameter(("qty" + i)));
			double price = Double.parseDouble(request.getParameter(("price" + i)));
			
			totalPrice += qty * price;
		 
		}
		
		return BigDecimal.valueOf(totalPrice);
		
	}
	
}
