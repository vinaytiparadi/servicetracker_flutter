import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../ form_validation/validation_logic.dart';
import '../utils/constants.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPrimaryContactNumberController =
      TextEditingController();
  TextEditingController customerSecondaryContactNumberController =
      TextEditingController();
  TextEditingController customerSmartPhoneBrandController =
      TextEditingController();
  TextEditingController customerSmartPhoneModelController =
      TextEditingController();
  TextEditingController totalRepairCostController = TextEditingController();
  TextEditingController advancePaidController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  TextEditingController totalAmountReceivedController = TextEditingController();
  TextEditingController phoneCollectorNameController = TextEditingController();

  TextEditingController deviceSubmittedDateController = TextEditingController();
  TextEditingController deviceCollectedDateController = TextEditingController();

  double balanceAmount = 0;

  DateTime _selectedSubmitDate = DateTime.now();
  String _submitformattedDate = '';
  Future<void> _selectSubmitDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedSubmitDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2040),
    );

    if (picked != null && picked != _selectedSubmitDate) {
      setState(() {
        _selectedSubmitDate = picked;
        _submitformattedDate = DateFormat('dd/MM/yyyy').format(picked);
        deviceSubmittedDateController.text = _submitformattedDate;
        // print(_submitformattedDate);
      });
    }
  }

  DateTime _selectedCollectDate = DateTime.now();
  String _collectformattedDate = '';
  Future<void> _selectCollectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCollectDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2040),
    );

    if (picked != null && picked != _selectedCollectDate) {
      setState(() {
        _selectedCollectDate = picked;
        _collectformattedDate = DateFormat('dd/MM/yyyy').format(picked);
        deviceCollectedDateController.text = _collectformattedDate;
        // print(_submitformattedDate);
      });
    }
  }

  @override
  void dispose() {
    customerNameController.dispose();
    customerPrimaryContactNumberController.dispose();
    customerSecondaryContactNumberController.dispose();
    customerSmartPhoneBrandController.dispose();
    customerSmartPhoneModelController.dispose();
    totalRepairCostController.dispose();
    advancePaidController.dispose();
    balanceAmountController.dispose();
    totalAmountReceivedController.dispose();
    phoneCollectorNameController.dispose();
    deviceSubmittedDateController.dispose();
    deviceCollectedDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: customerNameController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'Customer Name',
                    hintText: 'Enter Customer Name',
                  ),
                  validator: validateCustomerName,
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: customerPrimaryContactNumberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // maxLength: 10,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'Customer Contact Number (Primary)',
                    hintText: 'Enter Contact Number',
                  ),
                  validator: validateCustomerPrimaryContactNumber,
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: customerSecondaryContactNumberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // maxLength: 10,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'Customer Contact Number (Secondary)',
                    hintText: 'Enter Contact Number',
                  ),
                  validator: validateCustomerSecondaryContactNumber,
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: customerSmartPhoneBrandController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'SmartPhone Brand',
                    hintText: 'Enter SmartPhone Brand',
                  ),
                  validator: validateSmartPhoneBrand,
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: customerSmartPhoneModelController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'SmartPhone Model',
                    hintText: 'Enter SmartPhone Model',
                  ),
                  validator: validateSmartPhoneModel,
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: totalRepairCostController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'Total Repair Cost (in Rs.)',
                    hintText: 'Enter Repair Cost',
                  ),
                  validator: validateRepairCost,
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: advancePaidController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'Advanced Received (in Rs.)',
                    hintText: 'Enter Advanced Received',
                  ),
                  validator: validateRepairCost,
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: balanceAmountController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'Balance Amount (in Rs.)',
                    hintText: 'Enter Balance Amount',
                  ),
                  validator: validateRepairCost,
                  onTap: () {
                    balanceAmount =
                        double.parse(totalRepairCostController.text) -
                            double.parse(advancePaidController.text);
                    balanceAmountController.text = balanceAmount.toString();
                  },
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: totalAmountReceivedController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: 'Total Amount Received (in Rs.)',
                    hintText: 'Enter Total Amount Received',
                  ),
                  validator: validateRepairCost,
                  onTap: () {
                    totalAmountReceivedController.text =
                        advancePaidController.text;
                  },
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                TextFormField(
                  controller: phoneCollectorNameController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    border: outlineEnabledBorder(),
                    labelText: "Device Collector's Name",
                    hintText: 'Enter Name',
                  ),
                  validator: validateCustomerName,
                  onTap: () {
                    phoneCollectorNameController.text =
                        customerNameController.text;
                  },
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    _selectSubmitDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: deviceSubmittedDateController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        border: outlineEnabledBorder(),
                        labelText: 'Date of Submission',
                        hintText: 'Select Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    _selectCollectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: deviceCollectedDateController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        border: outlineEnabledBorder(),
                        labelText: 'Date of Collection',
                        hintText: 'Select Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scHeight(context) * 0.03,
                ),
                SizedBox(
                  height: scHeight(context) * 0.059,
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                          ),
                        );
                      }
                      // Timestamp timestamp = Timestamp.fromDate(_selectedSubmitDate);
                      // print(timestamp);
                    },
                    child: const Text("Save Data"),
                  ),
                ),
                SizedBox(
                  height: scHeight(context) * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}