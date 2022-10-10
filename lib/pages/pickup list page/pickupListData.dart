class PickupListData {
  String? id;
  String? drsUniqueId;
  String? routecode;
  String? hubId;
  String? messangerId;
  String? shipmentId;
  String? serviceType;
  String? cityId;
  String? drsDate;
  String? pickupCompleteDate;
  String? drsBarImage;
  String? drsBarCode;
  String? pickupStatus;
  String? pickupType;
  String? delivered;
  String? deleted;
  int? totalAwb;
  int? pickupDelivered;

  PickupListData(
      {this.id,
      this.drsUniqueId,
      this.routecode,
      this.hubId,
      this.messangerId,
      this.shipmentId,
      this.serviceType,
      this.cityId,
      this.drsDate,
      this.pickupCompleteDate,
      this.drsBarImage,
      this.drsBarCode,
      this.pickupStatus,
      this.pickupType,
      this.delivered,
      this.deleted,
      this.totalAwb,
      this.pickupDelivered});

  PickupListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drsUniqueId = json['drs_unique_id'];
    routecode = json['routecode'];
    hubId = json['hub_id'];
    messangerId = json['messanger_id'];
    shipmentId = json['shipment_id'];
    serviceType = json['serviceType'];
    cityId = json['city_id'];
    drsDate = json['drs_date'];
    pickupCompleteDate = json['pickup_complete_date'];
    drsBarImage = json['drs_bar_image'];
    drsBarCode = json['drs_bar_code'];
    pickupStatus = json['pickup_status'];
    pickupType = json['pickup_type'];
    delivered = json['delivered'];
    deleted = json['deleted'];
    totalAwb = json['total_awb'];
    pickupDelivered = json['pickup_delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['drs_unique_id'] = this.drsUniqueId;
    data['routecode'] = this.routecode;
    data['hub_id'] = this.hubId;
    data['messanger_id'] = this.messangerId;
    data['shipment_id'] = this.shipmentId;
    data['serviceType'] = this.serviceType;
    data['city_id'] = this.cityId;
    data['drs_date'] = this.drsDate;
    data['pickup_complete_date'] = this.pickupCompleteDate;
    data['drs_bar_image'] = this.drsBarImage;
    data['drs_bar_code'] = this.drsBarCode;
    data['pickup_status'] = this.pickupStatus;
    data['pickup_type'] = this.pickupType;
    data['delivered'] = this.delivered;
    data['deleted'] = this.deleted;
    data['total_awb'] = this.totalAwb;
    data['pickup_delivered'] = this.pickupDelivered;
    return data;
  }
}