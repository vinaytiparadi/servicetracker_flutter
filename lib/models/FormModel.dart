import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FormModel.g.dart';

class DateTimeConverter implements JsonConverter<Timestamp, DateTime> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}


@JsonSerializable(converters: [DateTimeConverter()])
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
  final Timestamp deviceSubmittedTimestamp;
  final Timestamp deviceCollectedTimestamp;
  final DateTime dateSubmitted;
  final DateTime dateCollected;

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
      this.deviceSubmittedTimestamp,
      this.deviceCollectedTimestamp,
      this.dateSubmitted,
      this.dateCollected);

  // FromJson
  factory FormData.fromJson(Map<String, dynamic> json) => _$FormDataFromJson(json);

  // ToJson
  Map<String, dynamic> toJson() => _$FormDataToJson(this);

}
