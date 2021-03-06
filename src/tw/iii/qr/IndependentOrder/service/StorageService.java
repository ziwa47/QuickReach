package tw.iii.qr.IndependentOrder.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.iii.qr.IndependentOrder.model.entity.Bundles;
import tw.iii.qr.IndependentOrder.model.entity.IordersDetail;
import tw.iii.qr.IndependentOrder.model.entity.Storage;
import tw.iii.qr.IndependentOrder.model.repository.AbstractDAO;
import tw.iii.qr.IndependentOrder.model.repository.StorageDAO;

@Service
public class StorageService extends AbstractService<Storage> {
	@Autowired
	private StorageDAO storageDAO;

	@Override
	protected AbstractDAO<Storage> getDAO() {
		return storageDAO;
	}

	/** 查詢商品現有庫存倉別及櫃位並存成Map<String , Object> */
	@Transactional
	public Map<String, Object> makeWarehouseAndPosisation(Map<String, Object> map, String sku) {

		try {
			List<Object> dataList = new LinkedList<Object>();
			
			List<Storage> list = storageDAO.selectStorageBySku(sku);

			if (list.size() != 0) {

				for (Storage storage : list) {
					Map<String, Object> dataMap = new HashedMap<String, Object>();
					System.out.println(BeanUtils.describe(storage));
					dataMap.put("qty",storage.getQty());
					dataMap.put("warehouse", storage.getWarehouse());
					dataMap.put("warehousePosition", storage.getWarehousePosition1()+"-"+storage.getWarehousePosition2());
					dataList.add(dataMap);
				}

			}

			map.put("data", dataList);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return map;

	}
	/* 單sku扣庫存用  */ 
	public void deductStock(IordersDetail iod){
		
		try {
			  Storage sto = storageDAO.selectStorageByIorderDetail(iod);
			  sto.setQty(sto.getQty()-iod.getQty());
			  update(sto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/* 組合包扣庫存用  */ 
	public void deductStock(IordersDetail iod,Bundles b){
		
		try {
			  int totalcount = iod.getQty() * b.getQty();
			  Storage sto = storageDAO.selectStorageByIorderDetail(iod);
			  sto.setQty(sto.getQty()- totalcount);
			  update(sto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	/* 單sku回庫存用  */ 
	public void addStock(IordersDetail iod){
		
		try {
			  Storage sto = storageDAO.selectStorageByIorderDetail(iod);
			  sto.setQty(sto.getQty()+iod.getQty());
			  update(sto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	/* 組合包回庫存用  */ 
	public void addStock(IordersDetail iod,Bundles b){
		
		try {
			  int totalcount = iod.getQty() * b.getQty();
			  Storage sto = storageDAO.selectStorageByIorderDetail(iod);
			  sto.setQty(sto.getQty()+ totalcount);
			  update(sto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	

}
