import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_tracker/models/FormModel.dart';

class EditableGlassCard extends StatefulWidget {
  final FormData data;
  final Function(FormData) onUpdate;

  EditableGlassCard({required this.data, required this.onUpdate});

  @override
  _EditableGlassCardState createState() => _EditableGlassCardState();
}

class _EditableGlassCardState extends State<EditableGlassCard> {
  bool isEditing = false;
  late TextEditingController customerNameController;
  late TextEditingController customerPrimaryContactNumberController;
  late TextEditingController customerSecondaryContactNumberController;
  late TextEditingController customerSmartPhoneBrandController;
  late TextEditingController customerSmartPhoneModelController;
  late TextEditingController customerSmartPhoneIssueController;
  late TextEditingController totalRepairCostController;
  late TextEditingController advancePaidController;
  late TextEditingController balanceAmountController;
  late TextEditingController totalAmountReceivedController;
  late TextEditingController phoneCollectorNameController;
  late TextEditingController deviceSubmittedDateController;
  late TextEditingController deviceCollectedDateController;

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
  void initState() {
    super.initState();
    customerNameController = TextEditingController(text: widget.data.customerName);
    customerPrimaryContactNumberController =
        TextEditingController(text: widget.data.customerPrimaryContactNumber);
    customerSecondaryContactNumberController = TextEditingController(text: widget.data.customerSecondaryContactNumber);
    customerSmartPhoneBrandController = TextEditingController(text: widget.data.customerSmartPhoneBrand);
    customerSmartPhoneModelController = TextEditingController(text: widget.data.customerSmartPhoneModel);
    customerSmartPhoneIssueController = TextEditingController(text: widget.data.deviceIssue);
    totalRepairCostController = TextEditingController(text: widget.data.totalRepairCost.toString());
    advancePaidController = TextEditingController(text: widget.data.advancePaid.toString());
    balanceAmountController = TextEditingController(text: widget.data.balanceAmount.toString());
    totalAmountReceivedController = TextEditingController(text: widget.data.totalAmount.toString());
    phoneCollectorNameController = TextEditingController(text: widget.data.phoneCollectorName);
    deviceSubmittedDateController = TextEditingController(text: widget.data.dateCollected.toString());
    deviceCollectedDateController = TextEditingController(text: widget.data.dateCollected.toString());
  }

  @override
  void dispose() {
    customerNameController.dispose();
    customerPrimaryContactNumberController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _updateDetails() async{
    // Create a new FormData object with the updated values
    final updatedData = FormData(
      customerNameController.text,
      customerPrimaryContactNumberController.text,
      '',
      '',
      '',
      0.0,
      0.0,
      0.0,
      0.0,
      'nice',
      DateTime.now(),
      DateTime.now(),
      696969,
      'new upodated issue',
      widget.data.documentId,
      // Assign updated values for other fields
    );

    // Call the provided onUpdate callback function
    widget.onUpdate(updatedData);
    print('now here');
    // try {
    //   final user = FirebaseAuth.instance.currentUser;
    //
    //
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user!.uid)
    //       .collection('service_history')
    //       .doc(widget.data.documentId)
    //       .update(updatedData.toJson());
    // } catch (error) {
    //   // Handle the error
    //   print('Error updating document: $error');
    // }

    // Hide the update button and toggle off editing mode
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xffdad5).withOpacity(1),
            blurRadius: 2.0,
            spreadRadius: 1.5,
          ),
        ],
        color: Colors.white.withOpacity(0.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x846c64).withOpacity(1.0),
                  ),
                ),
                isEditing
                    ? Expanded(
                  child: TextFormField(
                    controller: customerNameController,
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Color(0xbc9c94).withOpacity(1.0),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
                    : Text(
                  widget.data.customerName,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xbc9c94).withOpacity(1.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contact Number:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x846c64).withOpacity(1.0),
                  ),
                ),
                isEditing
                    ? Expanded(
                  child: TextFormField(
                    controller: customerPrimaryContactNumberController,
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Color(0xac8482).withOpacity(1.0),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
                    : Text(
                  '+91' + widget.data.customerPrimaryContactNumber,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xac8482).withOpacity(1.0),
                  ),
                ),
              ],
            ),
            // Add more fields with edit functionality
            const SizedBox(height: 8.0),
            isEditing
                ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _updateDetails,
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _toggleEdit,
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}