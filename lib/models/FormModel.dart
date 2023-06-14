import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FormModel.g.dart';

// class DateTimeConverter {
//   const DateTimeConverter();
//
//   static DateTime toJson(Timestamp timestamp) {
//     return timestamp.toDate();
//   }
//
//   static Timestamp fromJson(DateTime dateTime) {
//     return Timestamp.fromDate(dateTime);
//   }
// }


@JsonSerializable()
class FormData {
  final String customerName;
  final String customerPrimaryContactNumber;
  final String customerSecondaryContactNumber;
  final String customerSmartPhoneBrand;
  final String customerSmartPhoneModel;
  final double totalRepairCost;
  final double advancePaid;
  final double balanceAmount;
  final double totalAmount;
  final String phoneCollectorName;
  // @JsonKey(fromJson: DateTimeConverter.fromJson, toJson: DateTimeConverter.toJson)
  // final Timestamp deviceSubmittedTimestamp;
  // @JsonKey(fromJson: DateTimeConverter.fromJson, toJson: DateTimeConverter.toJson)
  // final Timestamp deviceCollectedTimestamp;
  final DateTime dateSubmitted;
  final DateTime dateCollected;
  final int timestamp;
  final String deviceIssue;

  FormData(
      this.customerName,
      this.customerPrimaryContactNumber,
      this.customerSecondaryContactNumber,
      this.customerSmartPhoneBrand,
      this.customerSmartPhoneModel,
      this.totalRepairCost,
      this.advancePaid,
      this.balanceAmount,
      this.totalAmount,
      this.phoneCollectorName,
      // this.deviceSubmittedTimestamp,
      // this.deviceCollectedTimestamp,
      this.dateSubmitted,
      this.dateCollected,
      this.timestamp, this.deviceIssue);

  // FromJson
  factory FormData.fromJson(Map<String, dynamic> json) => _$FormDataFromJson(json);

  // ToJson
  Map<String, dynamic> toJson() => _$FormDataToJson(this);

}
