package tw.iii.qr.IndependentOrder.model.repository;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import tw.iii.qr.IndependentOrder.model.entity.IcombineOrder;
import tw.iii.qr.IndependentOrder.model.entity.Storage;

@Repository
public class IcomebineOrderDAO extends AbstractDAO<IcombineOrder> {

	@Override
	protected Class<IcombineOrder> getEntityClass() {
		return IcombineOrder.class;
	}
	
	
}
