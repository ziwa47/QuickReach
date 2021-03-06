package tw.iii.qr.IndependentOrder.model.repository;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import tw.iii.qr.IndependentOrder.model.entity.IordersDetail;
import tw.iii.qr.IndependentOrder.model.entity.Storage;

@Repository
public class StorageDAO extends AbstractDAO<Storage> {

	@Override
	protected Class<Storage> getEntityClass() {
		return Storage.class;
	}

	@SuppressWarnings("unchecked")
	public List<Storage> selectStorageBySku(String sku) throws Exception {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(getEntityClass());
		criteria.add(Restrictions.eq("sku", sku));
		// System.out.println("sku = "+sku);
		System.out.println("criteria.list().size()=" + criteria.list().size());
		return criteria.list();
	}

	public Storage selectStorageBySku(IordersDetail iod, String sku) throws Exception {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(getEntityClass());
		String[] ware = iod.getWarehouse().split(",");
		String warehouse = ware[0];
		String[] location = ware[1].split("-");
		String location1 = location[0];
		String location2 = location[1];
		criteria.add(Restrictions.eq("sku", sku));
		criteria.add(Restrictions.eq("warehouse", warehouse));
		criteria.add(Restrictions.eq("warehousePosition1", location1));
		criteria.add(Restrictions.eq("warehousePosition2", location2));
		// System.out.println("sku = "+sku);

		return (Storage) criteria.list().get(0);
	}

	@SuppressWarnings("unchecked")
	public Storage selectStorageByIorderDetail(IordersDetail iod) throws Exception {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(getEntityClass());
		String warehouse = "";
		String location1 = "";
		String location2 = "";
		if (iod.getWarehouse() != null) {
			String[] ware = iod.getWarehouse().split(",");
			warehouse = ware[0];
			String[] location = ware[1].split("-");
			location1 = isNullorEmpty(location[0]) ? "" : location[0];
			location2 = isNullorEmpty(location[1]) ? "" : location[1];
		}
		criteria.add(Restrictions.eq("sku", iod.getSku()));
		criteria.add(Restrictions.eq("warehouse", warehouse));
		criteria.add(Restrictions.eq("warehousePosition1", location1));
		criteria.add(Restrictions.eq("warehousePosition2", location2));
		// System.out.println("sku = "+sku);

		return (Storage) criteria.list().get(0);
	}

	private static boolean isNullorEmpty(String s) {

		if (s == null || s.length() == 0)
			return true;

		return false;
	}

}
