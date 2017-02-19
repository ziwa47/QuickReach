package tw.iii.qr.IndependentOrder.model.entity;
// default package
// Generated 2017/2/18 �U�� 10:32:46 by Hibernate Tools 4.0.0.Final

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * IordersMaster generated by hbm2java
 */
@Entity
@Table(name = "iorders_master")
public class IordersMaster implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6315325721356186327L;
	private Integer item;
	private String qrId;
	private String transactionId;
	private String platform;
	private String guest;
	private Date orderDate;
	private Date payDate;
	private String logistics;
	private String orderStatus;
	private Date shippingDate;
	private BigDecimal shippingFees;
	private BigDecimal refundShippingFees;
	private BigDecimal otherFees;
	private BigDecimal paypalFees;
	private Boolean insurance;
	private BigDecimal insuranceFee;
	private BigDecimal insuranceTotal;
	private String currency;
	private BigDecimal weight;
	private BigDecimal totalWeight;
	private String fedexService;
	private String fedexPacking;
	private String staffName;
	private String size;
	private BigDecimal totalPrice;
	private String trackingCode;
	private String comment;
	private BigDecimal packageFees;
	private BigDecimal paypalTotal;
	private BigDecimal paypalNet;
	private String isCombine;
	private String combineSku;
	private BigDecimal paypalPrice;

	public IordersMaster() {
	}

	public IordersMaster(String qrId) {
		this.qrId = qrId;
	}

	public IordersMaster(String qrId, String transactionId, String platform, String guest, Date orderDate, Date payDate,
			String logistics, String orderStatus, Date shippingDate, BigDecimal shippingFees,
			BigDecimal refundShippingFees, BigDecimal otherFees, BigDecimal paypalFees, Boolean insurance,
			BigDecimal insuranceFee, BigDecimal insuranceTotal, String currency, BigDecimal weight,
			BigDecimal totalWeight, String fedexService, String fedexPacking, String staffName, String size,
			BigDecimal totalPrice, String trackingCode, String comment, BigDecimal packageFees, BigDecimal paypalTotal,
			BigDecimal paypalNet, String isCombine, String combineSku, BigDecimal paypalPrice) {
		this.qrId = qrId;
		this.transactionId = transactionId;
		this.platform = platform;
		this.guest = guest;
		this.orderDate = orderDate;
		this.payDate = payDate;
		this.logistics = logistics;
		this.orderStatus = orderStatus;
		this.shippingDate = shippingDate;
		this.shippingFees = shippingFees;
		this.refundShippingFees = refundShippingFees;
		this.otherFees = otherFees;
		this.paypalFees = paypalFees;
		this.insurance = insurance;
		this.insuranceFee = insuranceFee;
		this.insuranceTotal = insuranceTotal;
		this.currency = currency;
		this.weight = weight;
		this.totalWeight = totalWeight;
		this.fedexService = fedexService;
		this.fedexPacking = fedexPacking;
		this.staffName = staffName;
		this.size = size;
		this.totalPrice = totalPrice;
		this.trackingCode = trackingCode;
		this.comment = comment;
		this.packageFees = packageFees;
		this.paypalTotal = paypalTotal;
		this.paypalNet = paypalNet;
		this.isCombine = isCombine;
		this.combineSku = combineSku;
		this.paypalPrice = paypalPrice;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "Item", unique = true, nullable = false)
	public Integer getItem() {
		return this.item;
	}

	public void setItem(Integer item) {
		this.item = item;
	}

	@Column(name = "QR_id", nullable = false, length = 100)
	public String getQrId() {
		return this.qrId;
	}

	public void setQrId(String qrId) {
		this.qrId = qrId;
	}

	@Column(name = "transactionId", length = 100)
	public String getTransactionId() {
		return this.transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	@Column(name = "platform", length = 45)
	public String getPlatform() {
		return this.platform;
	}

	public void setPlatform(String platform) {
		this.platform = platform;
	}

	@Column(name = "guest", length = 45)
	public String getGuest() {
		return this.guest;
	}

	public void setGuest(String guest) {
		this.guest = guest;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "orderDate", length = 19)
	public Date getOrderDate() {
		return this.orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "payDate", length = 19)
	public Date getPayDate() {
		return this.payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	@Column(name = "logistics", length = 45)
	public String getLogistics() {
		return this.logistics;
	}

	public void setLogistics(String logistics) {
		this.logistics = logistics;
	}

	@Column(name = "orderStatus", length = 45)
	public String getOrderStatus() {
		return this.orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "shippingDate", length = 19)
	public Date getShippingDate() {
		return this.shippingDate;
	}

	public void setShippingDate(Date shippingDate) {
		this.shippingDate = shippingDate;
	}

	@Column(name = "shippingFees", precision = 10)
	public BigDecimal getShippingFees() {
		return this.shippingFees;
	}

	public void setShippingFees(BigDecimal shippingFees) {
		this.shippingFees = shippingFees;
	}

	@Column(name = "refundShippingFees", precision = 10)
	public BigDecimal getRefundShippingFees() {
		return this.refundShippingFees;
	}

	public void setRefundShippingFees(BigDecimal refundShippingFees) {
		this.refundShippingFees = refundShippingFees;
	}

	@Column(name = "otherFees", precision = 10)
	public BigDecimal getOtherFees() {
		return this.otherFees;
	}

	public void setOtherFees(BigDecimal otherFees) {
		this.otherFees = otherFees;
	}

	@Column(name = "paypalFees", precision = 10)
	public BigDecimal getPaypalFees() {
		return this.paypalFees;
	}

	public void setPaypalFees(BigDecimal paypalFees) {
		this.paypalFees = paypalFees;
	}

	@Column(name = "insurance")
	public Boolean getInsurance() {
		return this.insurance;
	}

	public void setInsurance(Boolean insurance) {
		this.insurance = insurance;
	}

	@Column(name = "insuranceFee", precision = 10)
	public BigDecimal getInsuranceFee() {
		return this.insuranceFee;
	}

	public void setInsuranceFee(BigDecimal insuranceFee) {
		this.insuranceFee = insuranceFee;
	}

	@Column(name = "insuranceTotal", precision = 10)
	public BigDecimal getInsuranceTotal() {
		return this.insuranceTotal;
	}

	public void setInsuranceTotal(BigDecimal insuranceTotal) {
		this.insuranceTotal = insuranceTotal;
	}

	@Column(name = "currency", length = 45)
	public String getCurrency() {
		return this.currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	@Column(name = "weight", precision = 10)
	public BigDecimal getWeight() {
		return this.weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}

	@Column(name = "totalWeight", precision = 10)
	public BigDecimal getTotalWeight() {
		return this.totalWeight;
	}

	public void setTotalWeight(BigDecimal totalWeight) {
		this.totalWeight = totalWeight;
	}

	@Column(name = "FedexService", length = 45)
	public String getFedexService() {
		return this.fedexService;
	}

	public void setFedexService(String fedexService) {
		this.fedexService = fedexService;
	}

	@Column(name = "FedexPacking", length = 45)
	public String getFedexPacking() {
		return this.fedexPacking;
	}

	public void setFedexPacking(String fedexPacking) {
		this.fedexPacking = fedexPacking;
	}

	@Column(name = "staffName", length = 45)
	public String getStaffName() {
		return this.staffName;
	}

	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}

	@Column(name = "size", length = 45)
	public String getSize() {
		return this.size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	@Column(name = "totalPrice", precision = 10)
	public BigDecimal getTotalPrice() {
		return this.totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Column(name = "trackingCode", length = 500)
	public String getTrackingCode() {
		return this.trackingCode;
	}

	public void setTrackingCode(String trackingCode) {
		this.trackingCode = trackingCode;
	}

	@Column(name = "comment", length = 100)
	public String getComment() {
		return this.comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Column(name = "packageFees", precision = 10)
	public BigDecimal getPackageFees() {
		return this.packageFees;
	}

	public void setPackageFees(BigDecimal packageFees) {
		this.packageFees = packageFees;
	}

	@Column(name = "paypalTotal", precision = 10)
	public BigDecimal getPaypalTotal() {
		return this.paypalTotal;
	}

	public void setPaypalTotal(BigDecimal paypalTotal) {
		this.paypalTotal = paypalTotal;
	}

	@Column(name = "paypalNet", precision = 10)
	public BigDecimal getPaypalNet() {
		return this.paypalNet;
	}

	public void setPaypalNet(BigDecimal paypalNet) {
		this.paypalNet = paypalNet;
	}

	@Column(name = "isCombine", length = 50)
	public String getIsCombine() {
		return this.isCombine;
	}

	public void setIsCombine(String isCombine) {
		this.isCombine = isCombine;
	}

	@Column(name = "CombineSku", length = 100)
	public String getCombineSku() {
		return this.combineSku;
	}

	public void setCombineSku(String combineSku) {
		this.combineSku = combineSku;
	}

	@Column(name = "paypalPrice", precision = 10)
	public BigDecimal getPaypalPrice() {
		return this.paypalPrice;
	}

	public void setPaypalPrice(BigDecimal paypalPrice) {
		this.paypalPrice = paypalPrice;
	}

}
